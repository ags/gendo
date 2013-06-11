source 'https://rubygems.org'

ruby '2.0.0'

gem 'active_attr'
gem 'jquery-rails'
gem 'pg'
gem 'rails', '4.0.0.rc1'
gem 'sorcery',
  git: 'git@github.com:NoamB/sorcery.git' # Support for rails 4 strong parameters
gem 'unicorn'

group :assets do
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'sass-rails', '~> 4.0.0.rc1'
  gem 'bootstrap-sass'
end

group :test do
  gem 'rspec-rails'
  gem 'turnip'
  gem 'capybara'
  gem 'machinist'
end

group :test, :development do
  gem 'dotenv-rails'
  gem 'quiet_assets'
end
