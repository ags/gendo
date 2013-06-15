module ApiV1
  class TransactionsController < ApiController
    def create
      transaction = Gendo::Transaction::Creator.create!(current_app, transaction_params)

      render json: {}, status: 201
    end

    private

    def transaction_params
      params.require(:transaction).permit(
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
        sql_events:  [:sql, :started_at, :ended_at, :duration, :name],
        view_events: [:identifier, :started_at, :ended_at, :duration]
      )
    end
  end
end
