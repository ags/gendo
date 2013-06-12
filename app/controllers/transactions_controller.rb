require "gendo/transaction_creator"

class TransactionsController < ApplicationController
  def create
    transaction_params = params.require(:transaction).permit(
      :controller,
      :action,
      :path,
      :format,
      :method,
      :status,
      :db_runtime,
      :view_runtime,
      :started_at,
      :ended_at,
      :duration,
      sql_events:  [:sql, :started_at, :ended_at, :duration],
      view_events: [:identifier, :started_at, :ended_at, :duration]
    )
    Gendo::TransactionCreator.create!(transaction_params)
    render nothing: true, status: 201
  end

  def index
    @transactions = Transaction.recent
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end
