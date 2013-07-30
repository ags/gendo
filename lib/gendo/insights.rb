module Gendo
  module Insights
    def self.all
      # TODO solve autoloading issue
      #Dir["#{Rails.root}/lib/gendo/insights/**/*.rb"].each { |f| require f }

      # constants.
      #   map { |constant| const_get(constant) }.
      #   select { |klass| Class === klass }.
      #   reject { |klass| klass == Gendo::Insights::Base }

      [
        Gendo::Insights::SendEmailAsync,
        Gendo::Insights::EagerLoadAssociations,
      ]
    end

    def self.applicable_to_source(source)
      all.map { |insight| insight.new(source) }.select(&:applicable?)
    end
  end
end
