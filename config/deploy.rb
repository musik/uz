set :application, "uz"
set :repository,  "git@github.com:musik/uz.git"

set :scm, :git

set :deploy_to, "/dat/www/uz"
role :web, "gxr"          
role :app, "gxr"                 
role :db,  "gxr", :primary => true
set :user, "muzik"
set :group, "muzik"
set :sockets_path,File.join(shared_path, "sockets")
set :use_sudo,false
set :using_rvm,false
ssh_options[:forward_agent] = true
set :sudoweb, "root@gxr"                 

set :branch, "master"
set :rake_bin, 'bundle exec rake'
set :deploy_via, :remote_cache
#set :git_shallow_clone, 1

set :default_environment, {
    'GEM_HOME' => '/home/muzik/.gem',
    'PATH' => "/home/muzik/.gem/bin:$PATH",
}
#recipes
require 'helpers'
require 'recipes/application'

#NGinx
set :nginx_remote_config,"/etc/nginx/sites-enabled/#{application}.conf"
set :nginx_local_config, "./lib/templates/nginx.conf.erb"
set :application_uses_ssl, false
set :nginx_host_name,"uz.sdmec.com"
set :nginx_host_uniq,false

require 'recipes/nginx'

set :environment, 'production'

require './lib/recipes/db.rb'
after "deploy:finalize_update","app:yml"
after "deploy:finalize_update","app:symlink"
after "deploy:finalize_update","deploy:migrate"
require './lib/recipes/custom.rb'

#Unicorn
set :unicorn_workers,2
set :unicorn_user,:muzik
require './lib/recipes/unicorn.rb'

after "deploy:create_symlink","unicorn:symlink"
after 'deploy:start','unicorn:start'
after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded

#Resque

#role :resque_worker, "gxr"
#role :resque_scheduler, "gxr"
#set :workers, { jibings: 1,sfda: 2 }
#require 'capistrano-resque'
#after "deploy:restart", "resque:restart"
#after "deploy:restart", "resque:scheduler:restart"

require "bundler/capistrano"

after "deploy:restart", "deploy:cleanup"
