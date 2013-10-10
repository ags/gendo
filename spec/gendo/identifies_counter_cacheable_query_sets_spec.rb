require_relative '../../app/gendo/identifies_counter_cacheable_query_sets'

describe IdentifiesCounterCacheableQuerySets do
  it "groups count queries by association" do
    count_event = double(
      "count event",
      sql: 'SELECT COUNT(*) FROM "comments"  WHERE "comments"."post_id" = $1'
    )

    insert_event = double(
      "insert event",
      sql: "INSERT INTO `bars` (`col`) VALUES (123)"
    )

    identified = described_class.identify(
      [count_event, insert_event],
      minimum_query_occurrences: 1
    )

    expect(identified).to eq({
      "comments" => [count_event]
    })
  end

  it "requires there to be 5 or more potential queries for a group by default" do
    queries = []
    count_events = 5.times.map do
      event = double(
        sql: 'SELECT COUNT(*) FROM "foos"  WHERE "foos"."bar_id" = $1'
      )
      queries << event
      event
    end

    4.times do
      queries << double(
        sql: 'SELECT COUNT(*) FROM "bars"  WHERE "bars"."qux_id" = $1'
      )
    end

    identified = described_class.identify(queries)

    expect(identified).to eq({"foos" => count_events})
  end
end
