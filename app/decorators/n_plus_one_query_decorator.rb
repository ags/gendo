class NPlusOneQueryDecorator < Draper::Decorator
  decorates_association :sql_events

  delegate_all
end
