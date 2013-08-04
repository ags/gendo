class MailerEventDecorator < Draper::Decorator
  include DecoratesEventTimestamps
  include HasUndecoratedClassName
  include DecoratesDuration

  decorates_association :app

  decorates_association :source

  decorates_association :request

  delegate_all

  delegate :duration, :name,
    to: :request,
    prefix: true

  delegate :name,
    to: :source,
    prefix: true

  delegate :name,
    to: :app,
    prefix: true
end
