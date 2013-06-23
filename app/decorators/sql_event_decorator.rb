class SqlEventDecorator < Draper::Decorator
  include DecoratesEventTimestamps
  include HasUndecoratedClassName

  delegate_all
end
