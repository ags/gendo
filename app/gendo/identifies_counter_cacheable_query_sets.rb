class IdentifiesCounterCacheableQuerySets
  def self.identify(sql_events, options={})
    new(sql_events, options).identify
  end

  def initialize(sql_events, options={})
    @sql_events = sql_events
    @minimum_query_occurrences = options[:minimum_query_occurrences] || 5
  end

  def identify
    potential_events_by_association.select do |_, events|
      events.size >= minimum_query_occurrences
    end
  end

  def potential_events_by_association
    potentials = {}
    sql_events.each do |event|
      if matches = matcher.match(event.sql)
        association_name = matches[:association_name]
        potentials[association_name] ||= []
        potentials[association_name] << event
      end
    end
    potentials
  end

  private

  def matcher
    @_matcher ||= /
      # select count
      SELECT \W* COUNT\(\*\) \W*

      # table name
      FROM \W* (?<association_name>\w*)
    /x
  end

  attr_reader :sql_events
  attr_reader :minimum_query_occurrences
end
