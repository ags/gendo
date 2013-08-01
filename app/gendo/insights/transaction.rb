module Insights
  module Transaction
    def self.all
      [
        SendEmailAsync,
        EagerLoadAssociations,
      ]
    end

    def self.applicable_to(transaction)
      all.map { |insight| insight.new(transaction) }.select(&:applicable?)
    end
  end
end
