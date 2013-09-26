class BulkInsertableDecorator < Draper::Decorator

  decorates_association :app

  decorates_association :source

  decorates_association :request

  decorates_association :sql_events

  delegate_all

  delegate :name,
    to: :app,
    prefix: true

  delegate :name,
    to: :source,
    prefix: true

  delegate \
      :name,
      :duration,
      :db_runtime,
    to: :request,
    prefix: true
end
