class AppDecorator < Draper::Decorator
  delegate_all

  decorates_association :transactions

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
    !sources.count.zero?
  end

  def recent_internal_server_errors(limit: 3)
    recent_transactions_with_status(500, limit: limit).decorate
  end
end
