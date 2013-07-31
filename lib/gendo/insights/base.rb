module Gendo
  module Insights
    class Base
      attr_reader :source

      def initialize(source)
        @source = source
      end

      def partial_name
        self.class.name.underscore.split("/").last
      end
    end
  end
end
