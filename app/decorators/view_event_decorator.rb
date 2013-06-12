class ViewEventDecorator < Draper::Decorator
  include DecoratesEventTimestamps

  delegate_all
end
