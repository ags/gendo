class TransactionsController < ApplicationController
  def create
    Transaction.transaction do # TODO not the clearest thing
      transaction_params = params.require(:transaction).permit(
        :controller,
        :action,
        :path,
        :format,
        :method,
        :status,
        :db_runtime,
        :view_runtime,
        :duration
      ).merge(started_at: Time.at(params[:transaction][:started_at].to_f),
              ended_at:   Time.at(params[:transaction][:ended_at].to_f))

      transaction = Transaction.create!(transaction_params)

      sql_events = params[:transaction].fetch(:sql_events) { [] }
      sql_events.each do |sql_event|
        transaction.sql_events.create!(
          sql:          sql_event[:sql],
          started_at:   Time.at(sql_event[:started_at].to_f),
          ended_at:     Time.at(sql_event[:ended_at].to_f),
          duration:     sql_event[:duration]
        )
      end

      view_events = params[:transaction].fetch(:view_events) { [] }
      view_events.each do |view_event|
        transaction.view_events.create!(
          identifier:   view_event[:identifier],
          started_at:   Time.at(view_event[:started_at].to_f),
          ended_at:     Time.at(view_event[:ended_at].to_f),
          duration:     view_event[:duration]
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
