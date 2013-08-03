module Insights
  module Request
    class Base
      attr_reader :request

      def initialize(request)
        @request = request
      end
    end
  end
end
