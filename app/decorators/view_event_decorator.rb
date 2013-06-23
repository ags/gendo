class ViewEventDecorator < Draper::Decorator
  include DecoratesEventTimestamps
  include HasUndecoratedClassName

  delegate_all
end
