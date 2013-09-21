class AppDecorator < Draper::Decorator
  delegate_all

  def alphabetized_sources
    sources.order(:controller, :action).decorate
  end

  def collecting_data?
    sources.any?
  end

  def recent_requests(limit: 25)
    requests.order(created_at: :desc).limit(limit).decorate
  end
end
