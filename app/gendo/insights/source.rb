module Insights
  module Source
    def self.all
      [
        Insights::Source::SendEmailAsync,
        Insights::Source::EagerLoadAssociations,
      ]
    end

    def self.applicable_to(source)
      all.map { |insight| insight.new(source) }.select(&:applicable?)
    end
  end
end
