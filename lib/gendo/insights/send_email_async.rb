module Gendo
  module Insights
    class SendEmailAsync < Base
      APPLICABILITY_LIFETIME = 1.day.ago

      def self.applicable_to_source?(source)
        source.mailer_events.
          where("mailer_events.created_at > ?", APPLICABILITY_LIFETIME).
          any?
      end
    end
  end
end
