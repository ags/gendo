module Gendo
  module Insights
    class Base
      def self.partial_name
        name.underscore.split("/").last
      end
    end
  end
end
