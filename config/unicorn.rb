worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
preload_app true
port = ENV["PORT"].to_i
listen port, tcp_nopush: false

after_fork do |server, worker|
  # db connection
  database_url = ENV['DATABASE_URL']
  if(database_url)
    ENV['DATABASE_URL'] = "#{database_url}?pool=35"
    ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
  else
    ActiveRecord::Base.establish_connection
  end
end
