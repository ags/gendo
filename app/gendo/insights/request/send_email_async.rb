module Insights
  module Request
    class SendEmailAsync < Base
      delegate :mailer_events, to: :request

      def applicable?
        mailer_events.any?
      end
    end
  end
end
