module Insights
  module Request
    class SendEmailAsync < Base
      def applicable?
        request.mailer_events.any?
      end
    end
  end
end
