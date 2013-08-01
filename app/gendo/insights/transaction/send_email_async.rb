module Insights
  module Transaction
    class SendEmailAsync < Base
      def applicable?
        transaction.mailer_events.any?
      end
    end
  end
end
