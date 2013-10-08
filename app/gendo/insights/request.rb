module Insights
  module Request
    def self.all
      [
        SendEmailAsync,
        EagerLoadAssociations,
        BulkInsertData,
        AddCounterCacheColumn,
      ]
    end

    def self.applicable_to(request)
      all.map { |insight| insight.new(request) }.select(&:applicable?)
    end
  end
end
