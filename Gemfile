source 'https://rubygems.org'

ruby '2.1.0'

gem 'active_attr', require: false
gem 'crummy'
gem 'draper'
gem 'jquery-rails'
gem 'oauth2', require: false
gem 'octokit', require: false
gem 'pg'
gem 'rails', '>= 4.0.1.rc2'
gem 'sidekiq'
gem 'slim'
gem 'unicorn'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
  # Staying on 4.1.6 for now as 4.2 > causes topbar issues
  gem 'zurb-foundation', '4.1.6'
  gem 'foundation-icons-sass-rails'
end

group :test do
  gem 'capybara',
    require: false

  gem 'database_cleaner',
    require: false

  gem 'machinist',
    require: false

  gem 'rspec-rails', '>= 3.0.0.beta1'

  gem 'simplecov',
    require: false

  gem 'vcr',
    require: false

  gem 'webmock',
    require: false
end

group :test, :development do
  gem 'dotenv-rails'
end

group :development, :production do
  # if you require 'sinatra' you get the DSL extended to Object
  gem 'sinatra', '>= 1.3.0', require: nil
end

group :development do
  gem 'foreman'
  gem 'quiet_assets'
end

group :production do
  gem 'rails_12factor'
  gem 'sentry-raven'
end

group :console do
  # Better REPL with debugging capability and some Rails integration.
  # https://github.com/rweng/pry-rails
  gem "pry-rails",
    group: :console
end
