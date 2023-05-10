namespace :db do
  desc "Drop the database and terminate all connections"
  # RAILS_ENV=development rails db:drop_with_connections
  task drop_with_connections: [:environment] do
    db_config = ActiveRecord::Base.connection_db_config.configuration_hash
    ActiveRecord::Base.establish_connection(db_config.merge(database: 'postgres'))

    ActiveRecord::Base.connection.execute("SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '#{db_config[:database]}' AND pid <> pg_backend_pid();")

    Rake::Task["db:drop"].invoke
  end
end