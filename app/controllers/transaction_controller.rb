class TransactionController < ApplicationController
  def create
    Transaction.create!(params.require(:transaction).permit(
      :controller,
      :action,
      :path,
      :format,
      :method,
      :status,
      :started_at,
      :ended_at,
      :db_runtime,
      :view_runtime,
      :duration
    ))

    render nothing: true, status: 201
  end
end
