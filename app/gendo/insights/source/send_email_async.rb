module Insights
  module Source
    class SendEmailAsync < Base
      APPLICABILITY_LIFETIME = 1.day

      def applicable?
        source.mailer_events.
          where("mailer_events.created_at > ?", APPLICABILITY_LIFETIME.ago).
          any?
      end

      def latest_mailer_event
        source.mailer_events.order(:created_at).last
      end
    end
  end
end
