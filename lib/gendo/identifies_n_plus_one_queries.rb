module Gendo
  class IdentifiesNPlusOneQueries
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
      potential_events_by_table.map do |table_name, sql_events|
        if sql_events.size >= @minimum_query_occurrences
          PotentialNPlusOneQuery.new(table_name, sql_events)
        end
      end.compact
    end

    private

    def potential_events_by_table
      potentials = {}
      @sql_events.each do |event|
        if matches = POTENTIAL_MATCHER.match(event.sql)
          table_name = matches[:table_name]
          potentials[table_name] ||= []
          potentials[table_name] << event
        end
      end
      potentials
    end

    DEFAULT_MINIMUM_QUERY_OCCURRENCES = 5

    POTENTIAL_MATCHER =
      /
      # select from
      SELECT .* \W*

      # table name
      FROM \W* (?<table_name>\w*) \W*

      # where a column is equal to a digit or a binding
      WHERE .*\W*=\W*(\d+) \W*

      # limited to one row
      LIMIT \W* 1
      /x
  end
end

class PotentialNPlusOneQuery < Struct.new(:table_name, :events)
end
