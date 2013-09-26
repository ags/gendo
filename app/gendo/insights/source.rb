module Insights
  module Source
    def self.all
      [
        SendEmailAsync,
        EagerLoadAssociations,
        BulkInsertData,
      ]
    end

    def self.applicable_to(source)
      all.map { |insight| insight.new(source) }.select(&:applicable?)
    end
  end
end
