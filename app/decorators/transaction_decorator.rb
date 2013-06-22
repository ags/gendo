class TransactionDecorator < Draper::Decorator
  include DecoratesEventTimestamps

  delegate_all

  decorates_association :sql_events

  decorates_association :view_events

  # delegate_all skips these
  delegate :source, to: :object

  def events
    (sql_events + view_events).sort_by(&:started_at)
  end

  def db_runtime
    "#{object.db_runtime} ms"
  end

  def view_runtime
    "#{object.view_runtime} ms"
  end

  def duration
    "#{object.duration} ms"
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
end
