class SourceDecorator < Draper::Decorator
  delegate_all

  def latest_transactions
    # consider moving this to model
    transactions.order("created_at DESC").decorate
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
    Gendo::Insights.applicable_to_source(object)
  end
end
