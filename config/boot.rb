require 'bundler/setup'
require 'active_record'

# add the lib/spec directories just like autotest does
#$:.unshift File.expand_path('./models')
#$:.unshift File.expand_path('./lib')
#$:.unshift File.expand_path('./spec')

# require all the models and libraries
project_root = File.expand_path('../..', __FILE__)
begin
models= Dir.glob(File.join( project_root, "models",'**', "*rb")) 
result =  models.collect { |file| [file, require( file )] }
libs= Dir.glob(File.join( project_root, "lib",'**', "*rb")) 
result += libs.reverse.collect { |file| [file, require( file )] }
# Mail-Definition 
# require File.expand_path('../../config/mail', __FILE__)
rescue NameError => e
	# this Message goes into the default log-file, specified in MyLog
	 require File.expand_path('../../lib/mylog', __FILE__)
	m= MyLog.new 
	m.log.fatal { "Error while requiring library-files" }
	m.log.fatal { libs.inspect }
	m.log.fatal { e.inspect }
	puts "Exiting : check log"
	exit
end
# if the programm is called with an argument, assume the last one specifies the environment
e=  ARGV.present? ? ARGV.last.downcase : 'development'
#
# or specify a Constand named "Env" in the master-file  (this is used by RSpec to switch to "test") 
#
begin
env = Env
rescue NameError
	env =  if e =~ /^p/
		      'production'
	      else
		      'development'
	      end
end
puts "Using #{env}-environment"
MyLog.new filename:env
logger =  MyLog.logger.log
logger.progname = 'boot'
logger.sev_threshold = env=='production' ? Logger::INFO : Logger::DEBUG  # WARN  # INFO # ERROR # FATAL
logger.info "----------------< starting >-------------------------------------------"
if files= result.collect{|f,s| f if s.nil?}.compact.present?
	logger.debug{ "unsuccessfully required files: #{files.join(';')} " }
end
ActiveRecord::Base.logger = logger
# open a connection to the db
Connection.connect environment:env
