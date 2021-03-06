class CreatesRequest
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

    @request = payload.except(
      :sql_events,
      :view_events,
      :mailer_events,
      :source
    )

    @request[:started_at] = Time(@request.fetch(:started_at))
    @request[:ended_at]   = Time(@request.fetch(:ended_at))

    events.each do |event|
      # TODO remove once the deep_symbolize_keys patch is in Rails master.
      event.deep_symbolize_keys!
      event[:started_at] = Time(event.fetch(:started_at))
      event[:ended_at] = Time(event.fetch(:ended_at))
    end
  end

  def create!
    @app.transaction do
      source = @app.find_or_create_source!(@source)

      request = source.requests.create!(@request)

      request.view_events.create!(@view_events)

      request.sql_events.create!(@sql_events)

      request.mailer_events.create!(@mailer_events)

      request
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
