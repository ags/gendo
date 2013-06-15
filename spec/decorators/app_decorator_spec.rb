require 'draper'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/decorators/app_decorator'

Draper::ViewContext.test_strategy :fast

describe AppDecorator do
end
