require 'draper'
require './spec/support/shared/decorates_duration'
require './spec/support/shared/decorates_event_timestamps'
require './spec/support/shared/has_undecorated_class_name'
require './app/decorators/decorates_event_timestamps'
require './app/decorators/has_undecorated_class_name'
require './app/decorators/decorates_duration'
require './app/decorators/sql_event_decorator'

Draper::ViewContext.test_strategy :fast

describe SqlEventDecorator do
  it_behaves_like "an object with decorated event timestamps"

  it_behaves_like "a decorator with undecorated class name methods"

  it_behaves_like "an object with a decorated duration"
end
