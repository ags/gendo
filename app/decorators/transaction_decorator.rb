class TransactionDecorator < Draper::Decorator
  include DecoratesEventTimestamps

  delegate_all

  decorates_association :sql_events

  decorates_association :view_events

  # delegate_all skips these
  delegate :method, :source, to: :object

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

  def time_breakdown_graph_data
    [
      {label: "Database", value: object.db_runtime},
      {label: "Views", value: object.view_runtime},
    ]
  end
end
