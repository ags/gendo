module Insights
  module Source
    class EagerLoadAssociations < Base
      REQUESTS_CHECKED_COUNT = 10

      delegate :latest_n_plus_one_query, to: :source

      def applicable?
        NPlusOneQuery.exists_for_requests?(checkable_requests)
      end

      private

      def checkable_requests
        source.latest_requests(limit: REQUESTS_CHECKED_COUNT)
      end
    end
  end
end
