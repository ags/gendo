module Gendo
  module Insights
    class EagerLoadAssociations < Base
      APPLICABILITY_LIFETIME = 1.day

      def applicable?
        source.n_plus_one_queries.
          where("n_plus_one_queries.created_at > ?", APPLICABILITY_LIFETIME.ago).
          any?
      end

      def latest_n_plus_one_query
        source.n_plus_one_queries.order(:created_at).last
      end
    end
  end
end
