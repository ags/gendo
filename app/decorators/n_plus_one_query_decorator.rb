class NPlusOneQueryDecorator < Draper::Decorator
  decorates_association :request

  decorates_association :sql_events

  delegate_all

  delegate :name, to: :request, prefix: true
end
