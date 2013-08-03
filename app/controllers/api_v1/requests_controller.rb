module ApiV1
  class RequestsController < ApiController
    def create
      ProcessRequestPayloadWorker.process_for_app(
        current_app,
        request_payload.to_h
      )

      render json: {}
    end

    private

    def request_payload
      params.require(:request).permit(
        :path,
        :status,
        :db_runtime,
        :view_runtime,
        :started_at,
        :ended_at,
        :duration,
        :shinji_version,
        :framework,
        source:        [:controller, :action, :format_type, :method_name],
        sql_events:    [:sql, :started_at, :ended_at, :duration, :name],
        view_events:   [:identifier, :started_at, :ended_at, :duration],
        mailer_events: [:mailer, :message_id, :started_at, :ended_at, :duration]
      )
    end
  end
end
