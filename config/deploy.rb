set :application, 'scores_api'
set :deploy_user, 'root'

set :scm, :git
set :repo_url, 'git@github.com:stager94/scores_api.git'

set :keep_releases, 5
set :linked_files, %w{config/database.yml config/unicorn.rb}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


set :format, :pretty
set :log_level, :debug

after 'deploy:publishing', 'deploy:restart'
before 'deploy:starting', 'rvm1:hook'
after 'deploy:finishing', 'deploy:cleanup'

namespace :deploy do
  task :restart do
    invoke 'faye:restart'
    invoke 'unicorn:restart'
  end

  task :invoke do
    fail 'no task provided' unless ENV['task']

    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, ENV['task']
        end
      end
    end
  end
end
