module Insights
  module Request
    class BulkInsertData < Base
      def applicable?
        request.bulk_insertables.any?
      end
    end
  end
end
