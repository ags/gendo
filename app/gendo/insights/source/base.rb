module Insights
  module Source
    class Base
      attr_reader :source

      def initialize(source)
        @source = source
      end

      def partial_name
        "/#{self.class.name.underscore}"
      end
    end
  end
end
