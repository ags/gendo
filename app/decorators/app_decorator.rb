class AppDecorator < Draper::Decorator
  delegate_all

  decorates_association :transactions

  def alphabetized_sources
    sources.order(:controller, :action)
  end

  def worst_sources_by_db_runtime(limit: 3)
    sources_by_median_desc(:db_runtime, limit: limit)
  end

  def worst_sources_by_view_runtime(limit: 3)
    sources_by_median_desc(:view_runtime, limit: limit)
  end

  def collecting_data?
    !sources.count.zero?
  end
end
