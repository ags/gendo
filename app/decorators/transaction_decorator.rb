class TransactionDecorator < Draper::Decorator
  include DecoratesEventTimestamps

  delegate_all

  decorates_association :sql_events

  decorates_association :view_events

  # delegate_all skips this
  delegate :method, to: :object

  def events
    (sql_events + view_events).sort_by(&:started_at)
  end

  def source
    "#{controller}##{action}"
  end
end
