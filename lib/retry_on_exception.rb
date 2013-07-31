module RetryOnException
  def retry_on_exception(exception_class, max_attempts: DEFAULT_RETRY_MAX_ATTEMPTS)
    attempts = 0
    begin
      yield
    rescue exception_class => e
      if attempts < max_attempts
        attempts += 1
        retry
      else
        raise
      end
    end
  end

  private

  DEFAULT_RETRY_MAX_ATTEMPTS = 3
end
