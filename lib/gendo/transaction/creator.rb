module Gendo
  module Transaction
    class Creator
      def self.create!(app, params)
        new(app, params).create!
      end

      def initialize(app, params)
        @app = app
        params = params.deep_symbolize_keys

        @sql_events    = params.fetch(:sql_events) { [] }
        @view_events   = params.fetch(:view_events) { [] }
        @mailer_events = params.fetch(:mailer_events) { [] }
        @source        = params.fetch(:source)

        @transaction = params.except(
          :sql_events,
          :view_events,
          :mailer_events,
          :source
        )

        @transaction[:started_at]   = Time(@transaction.fetch(:started_at))
        @transaction[:ended_at]     = Time(@transaction.fetch(:ended_at))
        @transaction[:duration]     = @transaction[:duration].to_f
        @transaction[:db_runtime]   = @transaction[:db_runtime].to_f
        @transaction[:view_runtime] = @transaction[:view_runtime].to_f

        events.each do |event|
          # TODO remove once the deep_symbolize_keys patch is in Rails master.
          event.deep_symbolize_keys!
          event[:started_at] = Time(event.fetch(:started_at))
          event[:ended_at] = Time(event.fetch(:ended_at))
        end
      end

      def create!
        # TODO this does a whole bunch of inserts, optimize this
        # TODO more generic event model would be nice
        User.transaction do
          source = @app.create_source!(@source)

          transaction = source.transactions.create!(@transaction)

          transaction.view_events.create!(@view_events)

          transaction.sql_events.create!(@sql_events)

          transaction.mailer_events.create!(@mailer_events)

          transaction
        end
      end

      private

      def events
        [@sql_events, @view_events, @mailer_events].flatten
      end

      def Time(timestamp)
        Time.at(timestamp.to_f)
      end
    end
  end
end
