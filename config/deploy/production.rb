set :user, "root"
role :app, %w{root@82.196.15.197}
role :web, %w{root@82.196.15.197}
role :db,  %w{root@82.196.15.197}

server '82.196.15.197', roles: %w{web app db}

set :rails_env, :production
set :rake, 'bundle exec rake'
set :deploy_to, '/var/www/scores_api'
set :branch, 'master'
set :unicorn_config_path, "#{shared_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

set :sidekiq_pid, "#{shared_path}/tmp/pids/sidekiq.pid"
set :sidekiq_log, "#{shared_path}/log/sidekiq.log"
set :sidekiq_config, "#{shared_path}/config/sidekiq.yml"
set :sidekiq_concurrency, 5
