# Needed to overwrite the already existing Rake task "load_config"
 class Rake::Task
	 def overwrite(&block)
		 @actions.clear
		 enhance(&block)
	 end
 end

 # Load the ActiveRecord tasks
 spec = Gem::Specification.find_by_name("activerecord")
 load File.join(spec.gem_dir, "lib", "active_record", "railties", "databases.rake")

 # Overwrite the load config to your needs
 Rake::Task["db:load_config"].overwrite do
	 ActiveRecord::Base.configurations = ActiveRecord::Tasks::DatabaseTasks.database_configuration = YAML::load(File.open('./config/database.yml'))  # YOUR_CONFIG_HASH_AS_IN_DATABASE_YML
	 ActiveRecord::Tasks::DatabaseTasks.db_dir = 'db' # PATH_TO_YOUR_DB_DIRECTORY
	 ActiveRecord::Tasks::DatabaseTasks.env    = 'development' # YOUR_ENV_AS_RAILS_ENV
 end

 # Migrations need an environment with an already established database connection
 task :environment => ["db:load_config"] do
	 ActiveRecord::Base.establish_connection ActiveRecord::Tasks::DatabaseTasks.database_configuration[ActiveRecord::Tasks::DatabaseTasks.env]
 end


