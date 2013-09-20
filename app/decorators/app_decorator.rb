class AppDecorator < Draper::Decorator
  delegate_all

  def alphabetized_sources
    sources.order(:controller, :action).decorate
  end

  def worst_sources_by_db_runtime(limit: 3)
    sources_by_median_desc(:db_runtime, limit: limit).decorate
  end

  def worst_sources_by_view_runtime(limit: 3)
    sources_by_median_desc(:view_runtime, limit: limit).decorate
  end

  def collecting_data?
    sources.any?
  end

  def recent_requests(limit: 25)
    requests.order(created_at: :desc).limit(limit).decorate
  end
end
