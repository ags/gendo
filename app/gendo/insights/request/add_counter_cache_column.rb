module Insights
  module Request
    class AddCounterCacheColumn < Base
      def applicable?
        request.counter_cacheable_query_sets.any?
      end
    end
  end
end
