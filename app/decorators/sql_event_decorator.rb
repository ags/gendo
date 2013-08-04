class SqlEventDecorator < Draper::Decorator
  include DecoratesEventTimestamps
  include HasUndecoratedClassName
  include DecoratesDuration

  delegate_all
end
