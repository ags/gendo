require 'draper'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/decorators/decorates_event_timestamps'
require './app/decorators/sql_event_decorator'

Draper::ViewContext.test_strategy :fast

describe SqlEventDecorator do
  it_behaves_like "an object with decorated event timestamps"
end
