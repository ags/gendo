class AppDecorator < Draper::Decorator
  delegate_all

  decorates_association :transactions

  def latest_transactions
    object.latest_transactions.decorate
  end

  def worst_sources_by_db_runtime(limit: 3)
    sources_by_median_desc(:db_runtime, limit: limit)
  end
end
