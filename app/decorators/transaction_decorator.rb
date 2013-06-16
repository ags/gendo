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
end
