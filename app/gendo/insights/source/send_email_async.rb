module Insights
  module Source
    class SendEmailAsync < Base
      APPLICABILITY_LIFETIME = 1.day

      delegate :latest_mailer_event, to: :source

      def applicable?
        source.
          mailer_events_created_after(APPLICABILITY_LIFETIME.ago).
          any?
      end
    end
  end
end
