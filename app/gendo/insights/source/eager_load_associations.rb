module Insights
  module Source
    class EagerLoadAssociations < Base
      TRANSACTIONS_CHECKED_COUNT = 10

      def applicable?
        NPlusOneQuery.exists?(transaction_id: checkable_transactions)
      end

      def latest_n_plus_one_query
        source.n_plus_one_queries.order(:created_at).last
      end

      private

      def checkable_transactions
        source.latest_transactions(limit: TRANSACTIONS_CHECKED_COUNT)
      end
    end
  end
end
