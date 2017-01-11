require "capistrano/setup"
require "capistrano/deploy"

require 'capistrano/bundler'
require 'capistrano/rvm'
require 'rvm1/capistrano3'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano3/unicorn'
# require 'capistrano/sidekiq'
require 'capistrano/rails/collection'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
