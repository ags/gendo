module Insights
  module Request
    class EagerLoadAssociations < Base
      def applicable?
        request.n_plus_one_queries.any?
      end
    end
  end
end
