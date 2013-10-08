module Insights
  module Source
    class AddCounterCacheColumn < Base
      REQUESTS_CHECKED_COUNT = 10

      delegate :latest_counter_cacheable_query_set,
        to: :source

      def applicable?
        CounterCacheableQuerySet.exists_for_requests?(latest_requests)
      end

      private

      def latest_requests
        source.latest_requests(limit: REQUESTS_CHECKED_COUNT)
      end
    end
  end
end
