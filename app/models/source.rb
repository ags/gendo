class Source < Struct.new(:app, :name)
  def to_s
    name
  end

  def transactions
    app.transactions_with_source(name)
  end

  def db
    DBStats.new(transactions)
  end

  class DBStats < Struct.new(:transactions)
    def median
      @_median ||= transactions.order(:db_runtime).median(:db_runtime)
    end
    def min
      @_min ||= transactions.order(:db_runtime).limit(1).first
    end
    def max
      @_max ||= transactions.order("db_runtime DESC").limit(1).first
    end
  end
end
