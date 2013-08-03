module Insights
  module Source
    class Base
      attr_reader :source

      def initialize(source)
        @source = source
      end
    end
  end
end
