module Gendo
  class TransactionStats < Struct.new(:transactions, :attribute)
    def initialize(transactions, attribute)
      super(
        transactions.
          where("db_runtime IS NOT NULL AND view_runtime IS NOT NULL"),
        attribute
      )
    end

    def median
      # using #first here attempts to do a LIMIT
      @_median ||= transactions.
        select("median(#{attribute}) AS median")[0].median
    end

    def min
      @_min ||= transactions.order(attribute).first
    end

    def max
      @_max ||= transactions.order("#{attribute} DESC").first
    end
  end
end
