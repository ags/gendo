module Insights
  module Transaction
    class EagerLoadAssociations < Base
      def applicable?
        transaction.n_plus_one_queries.any?
      end
    end
  end
end
