module Insights
  module Request
    def self.all
      [
        SendEmailAsync,
        EagerLoadAssociations,
      ]
    end

    def self.applicable_to(request)
      all.map { |insight| insight.new(request) }.select(&:applicable?)
    end
  end
end
