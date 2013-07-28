module Gendo
  module Insights
    class EagerLoadAssociations
      APPLICABILITY_LIFETIME = 1.day

      def self.applicable_to_source?(source)
        source.n_plus_one_queries.
          where("n_plus_one_queries.created_at > ?", APPLICABILITY_LIFETIME.ago).
          any?
      end
    end
  end
end
