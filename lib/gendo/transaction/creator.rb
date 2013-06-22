module Gendo
  module Transaction
    class Creator
      def self.create!(app, params)
        new(app, params).create!
      end

      def initialize(app, params)
        @app = app
        params = params.deep_symbolize_keys

        @sql_events =   params.fetch(:sql_events) { [] }
        @view_events =  params.fetch(:view_events) { [] }
        @source =       params.fetch(:source)

        @transaction = params.except(:sql_events, :view_events, :source)

        @transaction[:started_at] = Time(@transaction.fetch(:started_at))
        @transaction[:ended_at] = Time(@transaction.fetch(:ended_at))

        events.each do |event|
          event[:started_at] = Time(event.fetch(:started_at))
          event[:ended_at] = Time(event.fetch(:ended_at))
        end
      end

      def create!
        User.transaction do
          source = @app.sources.where(@source).first_or_create!
          transaction = source.transactions.create!(@transaction)

          @view_events.each do |view_event|
            transaction.view_events.create!(view_event)
          end

          @sql_events.each do |sql_event|
            transaction.sql_events.create!(sql_event)
          end

          transaction
        end
      end

      private

      def events
        [@sql_events, @view_events].flatten
      end

      def Time(timestamp)
        Time.at(timestamp.to_f)
      end
    end
  end
end
