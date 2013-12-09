require 'erb'

Capistrano::Configuration.instance.load do
  namespace :app do
    desc "|Custom| Create database.yml in shared path with settings for current stage and test env"
    task :yml do      
    end 
    task :symlink do
      upload './config/application.yml', "#{release_path}/config/application.yml"
      run "if [ ! -d '#{shared_path}/html' ]; then mkdir #{shared_path}/html; fi;"
      run "rm -rf #{release_path}/config/database.yml && ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
    task :whenever do
      #"cd #{current_path} && bundle exec rake whenever -w"
    end
  end
  namespace :unicorn do
    task :symlink do
      run "rm -rf #{current_path}/config/unicorn.rb && ln -nfs #{shared_path}/config/unicorn.rb #{current_path}/config/unicorn.rb"
    end
  end
  namespace :nginx do
    task :restart2, :roles => :sudoweb , :except => { :no_release => true } do
      run "service nginx restart"
    end
  end
  namespace :ss do
    task :rvm,:roles => :app do
      run "PATH=$PATH:$HOME/.rvm/bin;rvm use ruby-head"
    end
    task :uptime,:roles => :app do
      run "uptime"
    end
    task :bundle, :roles => :app do
      #run "which bundle"
      #run "gem install bundler"
    end
    task :update_rates, :roles => :app do
      run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec rails runner 'Shop::Import.new.update_all_rates'"
    end
  end
end
