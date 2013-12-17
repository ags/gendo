module ApiV1
  Error = Class.new(StandardError)
  NotFound = Class.new(Error)
  Unauthorized = Class.new(Error)
end
