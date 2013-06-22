class SourceDecorator < Draper::Decorator
  delegate_all

  def db
    Gendo::TransactionStats.new(transactions, :db_runtime)
  end

  def view
    Gendo::TransactionStats.new(transactions, :view_runtime)
  end

  def duration
    Gendo::TransactionStats.new(transactions, :duration)
  end
end
