source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
gem 'devise'
gem 'pg'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'russian', '~> 0.6.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'watir', '5.0.0'
gem 'watir-webdriver', '0.9.3'

gem 'traco'
gem "paperclip", "~> 5.0.0"
gem 'haml'
gem 'nokogiri'
gem 'pry'
gem 'pry-remote'
gem 'counter_culture', '~> 0.1.33'

gem 'sinatra'
gem 'sidekiq', '3.4.2'
gem 'sidetiq', '0.6.0'
gem 'ice_cube', '0.12.0'
gem 'sidekiq-unique-jobs'

gem 'pg_search'
gem 'active_model_serializers', '~> 0.10.0'
gem 'countries'
gem 'iconv'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :development, :test do
  gem 'capistrano', '~> 3.0',     require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',     require: false
  gem 'capistrano-bundler',     require: false
  gem 'rvm1-capistrano3',     require: false
  gem 'capistrano3-unicorn',     require: false
  gem 'capistrano-sidekiq',     require: false
  gem 'capistrano-rails-collection',     require: false
  # gem 'capistrano', '2.14.2'
  # gem 'rvm-capistrano', '1.4.1', require: false
  # gem 'capistrano_colors', '0.5.4', require: false
  # gem 'capistrano-ext', '1.2.1', require: false
  gem "letter_opener"
end

group :production do
  gem 'unicorn', '4.8.2'
end
