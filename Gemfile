source 'https://rubygems.org'

ruby '2.0.0'

gem 'active_attr'
gem 'bcrypt-ruby'
gem 'draper'
gem 'jquery-rails'
gem 'pg'
gem 'rails'
gem 'sentry-raven'
gem 'sidekiq'
# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', '>= 1.3.0', require: nil
gem 'slim'
gem 'unicorn'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
  gem 'zurb-foundation'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'machinist'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'timecop'
  gem 'turnip'
end

group :test, :development do
  gem 'dotenv-rails'
  gem 'quiet_assets'
end

group :development do
  gem 'foreman'
end

group :production do
  gem 'rails_12factor'
end
