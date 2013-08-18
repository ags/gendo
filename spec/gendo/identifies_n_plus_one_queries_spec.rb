require_relative "../../app/gendo/identifies_n_plus_one_queries"

describe IdentifiesNPlusOneQueries do
  it "returns the format of queries" do
    foo_event = double(
      "n+1 foo event",
      cached?: false,
      sql: "SELECT `foos`.* FROM `foos` WHERE `foos`.`id` = 13 LIMIT 1"
    )

    bar_event = double(
      "n+1 bar event",
      cached?: false,
      sql: "SELECT `bars`.* FROM `bars` WHERE `bars`.`id` = 27 LIMIT 1"
    )

    baz_event = double(
      "baz event",
      cached?: false,
      sql: "INSERT INTO `bars` (`col`) VALUES (123)"
    )

    identified = IdentifiesNPlusOneQueries.identify(
      [foo_event, bar_event, baz_event],
      minimum_query_occurrences: 1
    )

    expect(identified).to eq({
      "foos" => [foo_event],
      "bars" => [bar_event],
    })
  end

  it "by default requires there to be 5 or more potential queries on a table" do
    queries = []
    n_plus_one_events = 5.times.map do |id|
      event = double(
        "n+1 event #{id}",
        cached?: false,
        sql: "SELECT `foos`.* FROM `foos` WHERE `foos`.`id` = #{id} LIMIT 1"
      )
      queries << event
      event
    end

    4.times do
      queries << double(
        "n+1 format, lone event for different table",
        cached?: false,
        sql: "SELECT `bars`.* FROM `bars` WHERE `bars.`id` = 27 LIMIT 1"
      )
    end

    identified = IdentifiesNPlusOneQueries.identify(queries)

    expect(identified).to eq({"foos" => n_plus_one_events})
  end

  it "correctly identifies parameterized queries" do
    query = double(
      "parameterized query",
      cached?: false,
      sql: "SELECT `bars`.* FROM `bars` WHERE `bars.`id` = $1 LIMIT 1"
    )

    identified = IdentifiesNPlusOneQueries.identify(
      [query],
      minimum_query_occurrences: 1
    )

    expect(identified).to eq({"bars" => [query]})
  end

  it "ignores whitespace between statements" do
    query = double(
      "parameterized query",
      cached?: false,
      sql: "SELECT   `bars`.*   FROM   `bars`   WHERE `bars.`id` = 27   LIMIT 1"
    )

    identified = IdentifiesNPlusOneQueries.identify(
      [query],
      minimum_query_occurrences: 1
    )

    expect(identified).to eq({"bars" => [query]})
  end

  it "ignores cached events" do
    sql_events = 5.times.map do |id|
      double(
        "cache event #{id}",
        cached?: true,
        sql: "SELECT `foos`.* FROM `foos` WHERE `foos`.`id` = #{id} LIMIT 1"
      )
    end

    identified = IdentifiesNPlusOneQueries.identify(sql_events)

    expect(identified).to be_empty
  end
end
