source 'https://rubygems.org'

ruby '2.0.0'

gem 'active_attr', require: false
gem 'crummy'
gem 'draper'
gem 'jquery-rails'
gem 'oauth2'
gem 'octokit'
gem 'pg'
gem 'rails'
gem 'sidekiq'
gem 'slim'
gem 'unicorn'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
  gem 'zurb-foundation'
  gem 'foundation-icons-sass-rails'
end

group :test do
  gem 'capybara', require: false
  gem 'database_cleaner'
  gem 'machinist'
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end

group :test, :development do
  gem 'dotenv-rails'
  gem 'quiet_assets'
end

group :development, :production do
  # if you require 'sinatra' you get the DSL extended to Object
  gem 'sinatra', '>= 1.3.0', require: nil
end

group :development do
  gem 'foreman'
end

group :production do
  gem 'rails_12factor'
  gem 'sentry-raven'
end
