class SourceDecorator < Draper::Decorator
  delegate_all

  def latest_requests(limit: nil)
    source.latest_requests(limit: limit).decorate
  end

  def has_requests?
    requests.any?
  end

  def db
    RequestStats.new(requests, :db_runtime)
  end

  def view
    RequestStats.new(requests, :view_runtime)
  end

  def duration
    RequestStats.new(requests, :duration)
  end

  def insights
    @_insights ||= Insights::Source.applicable_to(object)
  end
end
