require_relative "../../app/gendo/identifies_bulk_insertables"

describe IdentifiesBulkInsertables do
  it "groups insert queries by table" do
    foo_event = double(
      "bulk insert foo event",
      sql: "INSERT INTO `foos` (`content`, `user_id`) VALUES ('a3573', 207)",
    )

    bar_event = double(
      "bulk insert bar event",
      sql: "INSERT INTO `bars` (`content`, `user_id`) VALUES ('d32nv', 123)",
    )

    baz_event = double(
      "bulk insert baz event",
      sql: "SELECT `bazs`.* FROM `bazs`"
    )

    identified = IdentifiesBulkInsertables.identify(
      [foo_event, bar_event, baz_event],
      minimum_query_occurrences: 1
    )

    expect(identified).to eq({
      "foos" => {%w(content user_id) => [foo_event]},
      "bars" => {%w(content user_id) => [bar_event]},
    })
  end

  it "differentiates on columns" do
    foo_event_a = double(
      "bulk insert foo event a",
      sql: "INSERT INTO `foos` (`content`, `user_id`) VALUES ('a', 207)",
    )

    foo_event_b = double(
      "bulk insert foo event b",
      sql: "INSERT INTO `foos` (`title`, `user_id`) VALUES ('b', 207)",
    )

    identified = IdentifiesBulkInsertables.identify(
      [foo_event_a, foo_event_b],
      minimum_query_occurrences: 1
    )

    expect(identified).to eq({
      "foos" => {
        %w(content user_id) => [foo_event_a],
        %w(title user_id)   => [foo_event_b],
      }
    })
  end

  it "requires 5 or more potential queries on a table" do
    queries = []
    bulk_insert_events = 5.times.map do |id|
      event = double(
        "bulk insert foo event #{id}",
        cached?: false,
        sql: "INSERT INTO `foos` (`content`, `user_id`) VALUES ('a', #{id})",
      )
      queries << event
      event
    end

    4.times do |id|
      queries << double(
        "bulk insert bar event #{id}",
        sql: "INSERT INTO `bars` (`title`, `user_id`) VALUES ('b', #{id})",
      )
    end

    identified = IdentifiesBulkInsertables.identify(queries)

    expect(identified).to eq({
      "foos" => {%w(content user_id) => bulk_insert_events}
    })
  end

  it "supports the postgres SQL format" do
    foo_event = double(
      "bulk insert foo event",
      sql: 'INSERT INTO "foos" ("title", "user_id") VALUES ($1, $2, $3, $4) RETURNING "id"'
    )

    identified = IdentifiesBulkInsertables.identify(
      [foo_event],
      minimum_query_occurrences: 1
    )

    expect(identified).to eq({
      "foos" => {
        %w(title user_id) => [foo_event],
      }
    })
  end
end
