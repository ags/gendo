class SourceDecorator < Draper::Decorator
  delegate_all

  delegate :name,
    to: :app,
    prefix: true

  def latest_requests(limit: nil)
    source.latest_requests(limit: limit).decorate
  end

  def has_requests?
    requests.any?
  end

  def median_request_duration
    @_median_request_duration ||= requests.median(:duration)
  end

  def median_request_db_runtime
    @_median_request_db_runtime ||= requests.median(:db_runtime)
  end

  def median_request_view_runtime
    @_median_request_view_runtime ||= requests.median(:view_runtime)
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
