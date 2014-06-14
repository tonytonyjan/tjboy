namespace :god do
  desc 'Restart god'
  task :restart do
    on roles(:app) do
      execute :sudo, :god, :restart, :dodo
    end
  end
end
after :'deploy:restart', :'god:restart'