module Insights
  module Request
    class Base
      attr_reader :request

      def initialize(request)
        @request = request
      end

      def partial_name
        "/#{self.class.name.underscore}"
      end
    end
  end
end
