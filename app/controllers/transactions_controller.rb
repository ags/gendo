class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.recent
  end

  def show
    @transaction = Transaction.find(params[:id]).decorate
  end
end
