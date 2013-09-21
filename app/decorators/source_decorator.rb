class SourceDecorator < Draper::Decorator
  delegate_all

  delegate :name,
    to: :app,
    prefix: true

  # TODO counter cache would be handy
  def requests_count
    requests.count
  end

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
    @_insights ||= InsightDecorator.decorate_collection(
      Insights::Source.applicable_to(object)
    )
  end

  def request_duration_breakdown_graph_data
    median_request_duration_by_day.
      limit(100).
      map { |request|
        {date: request.date, value: request.duration}
      }
  end
end
