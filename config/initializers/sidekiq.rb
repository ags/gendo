Sidekiq.configure_server do |config|
  redis_url = ENV["REDIS_URL"]
  if redis_url
    config.redis = {url: redis_url}
  end

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=35"
    ActiveRecord::Base.establish_connection
  end
end
