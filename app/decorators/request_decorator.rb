class RequestDecorator < Draper::Decorator
  include DecoratesEventTimestamps
  include DecoratesDuration

  delegate_all

  decorates_association :sql_events

  decorates_association :view_events

  decorates_association :mailer_events

  # source is an alias for object, so delegate_all skips it
  delegate :source, to: :object

  delegate :name,
    to: :source,
    prefix: true

  delegate :name,
    to: :app,
    prefix: true

  def events
    (sql_events + view_events + mailer_events).sort_by(&:started_at)
  end

  def db_runtime
    "#{object.db_runtime.round(2)} ms"
  end

  def view_runtime
    "#{object.view_runtime.round(2)} ms"
  end

  def name
    "Request #{id}"
  end

  def collected_timings?
    object.db_runtime.present? && object.view_runtime.present?
  end

  def time_breakdown_graph_data
    [
      {label: "Database", value: object.db_runtime},
      {label: "Views", value: object.view_runtime},
    ]
  end

  def fuzzy_timestamp
    "#{h.distance_of_time_in_words_to_now(created_at)} ago"
  end

  def insights
    @_insights ||= InsightDecorator.decorate_collection(
      Insights::Request.applicable_to(object)
    )
  end
end
