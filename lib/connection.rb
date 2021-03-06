class Connection

	def self.connect(environment:'production')
		ActiveRecord::Base.configurations = ActiveRecord::Tasks::DatabaseTasks.database_configuration = YAML::load File.open( File.expand_path('../../config/database.yml', __FILE__)) # YOUR_CONFIG_HASH_AS_IN_DATABASE_YML
		ActiveRecord::Tasks::DatabaseTasks.db_dir = 'db' # PATH_TO_YOUR_DB_DIRECTORY
		ActiveRecord::Tasks::DatabaseTasks.env    = environment # YOUR_ENV_AS_RAILS_ENV

		ActiveRecord::Base.establish_connection(ActiveRecord::Tasks::DatabaseTasks.database_configuration[ActiveRecord::Tasks::DatabaseTasks.env])
	end
end
