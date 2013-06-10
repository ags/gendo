class TransactionsController < ApplicationController
  def create
    Transaction.transaction do # TODO not the clearest thing
      transaction = Transaction.create!(params.require(:transaction).permit(
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

      sql_events = params[:transaction].fetch(:sql_events) { [] }
      sql_events.each do |sql_event|
        transaction.sql_events.create!(
          sql:          sql_event[:sql],
          started_at:   sql_event[:started_at],
          ended_at:     sql_event[:ended_at],
          duration:     sql_event[:duration]
        )
      end
    end

    render nothing: true, status: 201
  end

  def index
    @transactions = Transaction.recent
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end
