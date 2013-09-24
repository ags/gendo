class IdentifiesBulkInsertables
  def self.identify(sql_events, options={})
    new(sql_events, options).identify
  end

  def initialize(sql_events, options={})
    @sql_events = sql_events
    @minimum_query_occurrences = options.fetch(
      :minimum_query_occurrences,
      DEFAULT_MINIMUM_QUERY_OCCURRENCES
    )
  end

  def identify
    Hash[
      potential_events_by_table.map { |table_name, events_by_columns|
        events = filter_by_minimum_query_occurrences(events_by_columns)

        if events.any?
          [table_name, events]
        end
      }.compact
    ]
  end

  private

  def filter_by_minimum_query_occurrences(events_by_columns)
    events_by_columns.select { |_, events|
      events.size >= @minimum_query_occurrences
    }
  end

  def potential_events_by_table
    potentials = {}
    @sql_events.each do |event|
      table_name, *columns = event.sql.scan(POTENTIAL_MATCHER).map(&:last)
      if table_name && columns
        potentials[table_name] ||= {}
        potentials[table_name][columns] ||= []
        potentials[table_name][columns] << event
      end
    end
    potentials
  end

  DEFAULT_MINIMUM_QUERY_OCCURRENCES = 5

  POTENTIAL_MATCHER =
    /
    # excludes 'RETURNING '
    (
      INTO\W|   # 'INTO '
      \(|       # '('
      \,\W      # ', '
    )

    # columns are strings quoted with ` or "
    ["`](\w+)["`]
    /x
end
