# Invoke migrations with 
#  rake db:create {production|development}
#  if the argument is omitted, "development" is assumed
#  shortcut for production is "p"
#
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
	 # let's use the last parameter to switch the environment
	 e=  ARGV.size > 1 ? ARGV.last.downcase : 'development'
	 environment = if e =~ /^p/
			       'production'
		       else
			       'development'
		       end
	 # we have to define a new rake task on the fly with the same name as the value of our argument. 
	 # If we don’t do this, rake will attempt to invoke a task for each command line argument.
	 task ARGV.last.to_sym do; end 
	 ActiveRecord::Base.configurations = ActiveRecord::Tasks::DatabaseTasks.database_configuration = YAML::load(File.open('./config/database.yml'))  # YOUR_CONFIG_HASH_AS_IN_DATABASE_YML
	 ActiveRecord::Tasks::DatabaseTasks.db_dir = 'db' # PATH_TO_YOUR_DB_DIRECTORY
	 ActiveRecord::Tasks::DatabaseTasks.env    = environment # YOUR_ENV_AS_RAILS_ENV

 end

 # Migrations need an environment with an already established database connection
 task :environment => ["db:load_config"] do
	 ActiveRecord::Base.establish_connection ActiveRecord::Tasks::DatabaseTasks.database_configuration[ActiveRecord::Tasks::DatabaseTasks.env]
 end


 require 'rspec/core/rake_task'

 RSpec::Core::RakeTask.new do |task|
	 task.rspec_opts = ['--color', '--format', 'doc']
 end
