lock '3.7.1'

set :application, 'moe_creator.com'
set :repo_url, 'git@github.com:keisuke2236/moe_creator.git'

set :branch, ENV['BRANCH'] || 'master'

set :deploy_to, '/var/www/vhosts/moe_creator.com'

set :scm, :git

set :format, :airbrussh
set :log_level, :debug
set :pty, true

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}

set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
