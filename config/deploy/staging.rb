set :user, "root"
role :app, %w{root@5.9.32.194}
role :web, %w{root@5.9.32.194}
role :db,  %w{root@5.9.32.194}

server '5.9.32.194', roles: %w{web app db}

set :rails_env, :production
set :rake, 'bundle exec rake'
set :deploy_to, '/var/www/scores_api'
set :branch, 'master'
set :unicorn_config_path, "#{shared_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
