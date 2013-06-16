class Source < Struct.new(:app, :name)
  def to_s
    name
  end

  def transactions
    app.transactions_with_source(name)
  end

  def db
    AttributeStats.new(transactions, :db_runtime)
  end

  def view
    AttributeStats.new(transactions, :view_runtime)
  end

  def duration
    AttributeStats.new(transactions, :duration)
  end

  class AttributeStats < Struct.new(:transactions, :attribute)
    def median
      # using #first here attempts to do a LIMIT
      @_median ||= transactions.
        select("median(#{attribute}) AS median")[0].median
    end

    def min
      @_min ||= transactions.order(attribute).limit(1).first
    end

    def max
      @_max ||= transactions.order("#{attribute} DESC").limit(1).first
    end
  end
end
