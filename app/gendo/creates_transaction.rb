class CreatesTransaction
  def self.create!(app, payload)
    new(app, payload).create!
  end

  def initialize(app, payload)
    @app = app
    payload = payload.deep_symbolize_keys

    @sql_events    = payload.fetch(:sql_events) { [] }
    @view_events   = payload.fetch(:view_events) { [] }
    @mailer_events = payload.fetch(:mailer_events) { [] }
    @source        = payload.fetch(:source)

    @transaction = payload.except(
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
      source = @app.find_or_create_source!(@source)

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
