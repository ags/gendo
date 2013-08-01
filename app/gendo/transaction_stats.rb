class TransactionStats < Struct.new(:transactions, :attribute)
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

  private

  def transactions
    super.where("#{attribute} IS NOT NULL")
  end
end
