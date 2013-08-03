class RequestStats < Struct.new(:requests, :attribute)
  def median
    # using #first here attempts to do a LIMIT
    @_median ||= requests.
      select("median(#{attribute}) AS median")[0].median
  end

  def min
    @_min ||= requests.order(attribute).first
  end

  def max
    @_max ||= requests.order("#{attribute} DESC").first
  end

  private

  def requests
    super.where("#{attribute} IS NOT NULL")
  end
end
