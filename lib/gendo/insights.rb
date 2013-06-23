module Gendo
  module Insights
    def self.all
      # TODO solve autoloading issue
      #Dir["#{Rails.root}/lib/gendo/insights/**/*.rb"].each { |f| require f }

      # constants.
      #   map { |constant| const_get(constant) }.
      #   select { |klass| Class === klass }.
      #   reject { |klass| klass == Gendo::Insights::Base }

      [Gendo::Insights::SendEmailAsync]
    end

    def self.applicable_to_source(source)
      all.select { |insight| insight.applicable_to_source?(source) }
    end
  end
end
