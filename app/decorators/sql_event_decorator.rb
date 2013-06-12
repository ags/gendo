class SqlEventDecorator < Draper::Decorator
  include DecoratesEventTimestamps

  delegate_all
end
