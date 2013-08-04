class MailerEventDecorator < Draper::Decorator
  include DecoratesEventTimestamps
  include HasUndecoratedClassName
  include DecoratesDuration

  decorates_association :request

  delegate_all

  delegate :duration, to: :request, prefix: true
end
