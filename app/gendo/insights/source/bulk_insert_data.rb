module Insights
  module Source
    class BulkInsertData < Base
      REQUESTS_CHECKED_COUNT = 10

      delegate :latest_bulk_insertable, to: :source

      def applicable?
        BulkInsertable.exists_for_requests?(latest_requests)
      end

      private

      def latest_requests
        source.latest_requests(limit: REQUESTS_CHECKED_COUNT)
      end
    end
  end
end
