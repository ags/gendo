module Gendo
  class TransactionCreator
    def self.create!(params)
      new(params).create!
    end

    def initialize(params)
      params = params.deep_symbolize_keys
      @sql_events = params.fetch(:sql_events) { [] }
      @view_events = params.fetch(:view_events) { [] }
      @transaction = params.except(:sql_events, :view_events)

      @transaction[:started_at] = timestamp_to_time(@transaction.fetch(:started_at))
      @transaction[:ended_at] = timestamp_to_time(@transaction.fetch(:ended_at))

      events.each do |event|
        event[:started_at] = timestamp_to_time(event.fetch(:started_at))
        event[:ended_at] = timestamp_to_time(event.fetch(:ended_at))
      end
    end

    def create!
      user = User.last
      User.transaction do
        transaction = Transaction.create!(@transaction.merge(user: user))
        @view_events.each do |view_event|
          transaction.view_events.create!(view_event)
        end
        @sql_events.each do |sql_event|
          transaction.sql_events.create!(sql_event)
        end
      end
    end

    def events
      [@sql_events, @view_events].flatten
    end

    def timestamp_to_time(timestamp)
      Time.at(timestamp.to_f)
    end
  end
end
