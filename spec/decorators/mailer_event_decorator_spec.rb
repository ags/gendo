require 'draper'
require './spec/support/shared_examples_for_decorates_duration'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './spec/support/shared_examples_for_has_undecorated_class_name'
require './app/decorators/decorates_event_timestamps'
require './app/decorators/has_undecorated_class_name'
require './app/decorators/decorates_duration'
require './app/decorators/mailer_event_decorator'

Draper::ViewContext.test_strategy :fast

class MailerEvent; end

describe MailerEventDecorator do
  it_behaves_like "an object with decorated event timestamps"

  it_behaves_like "a decorator with undecorated class name methods"

  it_behaves_like "an object with a decorated duration"
end
