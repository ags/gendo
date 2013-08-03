module Insights
  module Source
    class EagerLoadAssociations < Base
      REQUESTS_CHECKED_COUNT = 10

      def applicable?
        NPlusOneQuery.exists?(request_id: checkable_requests)
      end

      def latest_n_plus_one_query
        source.n_plus_one_queries.order(:created_at).last
      end

      private

      def checkable_requests
        source.latest_requests(limit: REQUESTS_CHECKED_COUNT)
      end
    end
  end
end
