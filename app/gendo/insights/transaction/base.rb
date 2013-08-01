module Insights
  module Transaction
    class Base
      attr_reader :transaction

      def initialize(transaction)
        @transaction = transaction
      end

      def partial_name
        "/#{self.class.name.underscore}"
      end
    end
  end
end
