class NPlusOneQueryDecorator < Draper::Decorator
  include DecoratesDuration

  decorates_association :request

  decorates_association :sql_events

  delegate_all

  delegate :source_name, to: :request

  delegate :duration, to: :request, prefix: true

  delegate :db_runtime, to: :request, prefix: true

  def percentage_of_db_runtime
    percentage(object.duration, request_db_runtime)
  end

  def percentage_of_request_duration
    percentage(object.duration, request_duration)
  end

  private

  def percentage(x, y)
    return 0 if y.to_f.zero?
    ((x / y.to_f) * 100).round(2)
  end
end
