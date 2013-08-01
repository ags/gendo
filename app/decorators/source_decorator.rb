class SourceDecorator < Draper::Decorator
  delegate_all

  def latest_transactions(limit: nil)
    source.latest_transactions(limit: limit).decorate
  end

  def has_transactions?
    transactions.any?
  end

  def db
    Gendo::TransactionStats.new(transactions, :db_runtime)
  end

  def view
    Gendo::TransactionStats.new(transactions, :view_runtime)
  end

  def duration
    Gendo::TransactionStats.new(transactions, :duration)
  end

  def insights
    @_insights ||= Insights::Source.applicable_to(object)
  end
end
