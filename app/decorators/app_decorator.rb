class AppDecorator < Draper::Decorator
  delegate_all

  decorates_association :transactions

  def latest_transactions
    object.latest_transactions.decorate
  end
end
