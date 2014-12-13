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
## place to require further config-files eg
# require File.expand_path('../../config/mail', __FILE__)
rescue NameError => e
	# this Message goes into the default log-file, specified in MyLog
	require File.expand_path('../../lib/mylog', __FILE__)  # ensure that mylog is available
	m= MyLog.new 
	m.log.fatal { "Error while requiring library-files" }
	m.log.fatal { libs.inspect }
	m.log.fatal { e.inspect }
	puts "Exiting : check log"
	exit
end
e=  ARGV.present? ? ARGV.last.downcase : 'development'
env = if e =~ /^p/
		      'production'
	      else
		      'development'
	      end
MyLog.new filename:env
logger =  MyLog.logger.log
ActiveRecord::Base.logger = logger
logger.progname = 'boot'
logger.sev_threshold = env=='production' ? Logger::INFO : Logger::DEBUG  # WARN  # INFO # ERROR # FATAL
logger.info "----------------< starting >-------------------------------------------"
if files= result.collect{|f,s| f if s.nil?}.compact.present?
	logger.debug{ "unsuccessfully required files: #{files.join(';')} " }
end
# open a connection to the db
Connection.connect environment:env
