source 'https://rubygems.org'

ruby '2.1.0'

gem 'active_attr', require: false
gem 'crummy'
gem 'draper'
gem 'jquery-rails'
gem 'oauth2', require: false
gem 'octokit', require: false
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
  gem 'capybara',
    git: 'git@github.com:jnicklas/capybara.git',
    require: false

  gem 'database_cleaner',
    require: false

  gem 'machinist',
    require: false

  gem 'rspec-expectations',
    git: 'git@github.com:rspec/rspec-expectations.git'
  gem 'rspec-mocks',
    git: 'git@github.com:rspec/rspec-mocks.git'
  gem 'rspec-core',
    git: 'git@github.com:rspec/rspec-core.git'
  gem 'rspec',
    git: 'git@github.com:rspec/rspec.git'
  gem 'rspec-rails',
    git: 'git@github.com:rspec/rspec-rails.git'

  gem 'simplecov',
    require: false

  gem 'vcr',
    require: false

  gem 'webmock',
    require: false
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
