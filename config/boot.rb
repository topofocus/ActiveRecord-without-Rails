require 'bundler/setup'
require 'active_record'

# add the lib/spec directories just like autotest does
#$:.unshift File.expand_path('./models')
#$:.unshift File.expand_path('./lib')
#$:.unshift File.expand_path('./spec')

# require all the models and libraries
project_root = File.expand_path('../..', __FILE__)
models= Dir.glob(File.join( project_root, "models",'**', "*rb")) 
result =  models.collect { |file| [file, require( file )] }
libs= Dir.glob(File.join( project_root, "lib",'**', "*rb")) 
begin
result << libs.reverse.collect { |file| [file, require( file )] }
rescue NameError => e
	# this Message goes into the default log-file, specified in MyLog
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
puts "ARGV: #{ARGV.inspect}"	     
puts "Environment --> #{env}"
MyLog.new filename:env
logger =  MyLog.logger.log
logger.progname = 'boot'
logger.sev_threshold = env=='production' ? Logger::INFO : Logger::DEBUG  # WARN  # INFO # ERROR # FATAL
logger.info "----------------< starting >-------------------------------------------"
if files= result.collect{|f,s| f if s.nil?}.compact.present?
	logger.debug{ "unsuccessfully required files: #{files.join(';')} " }
end
# open a connection to the db
#require File.expand_path('../../lib/connection', __FILE__)
ActiveRecord::Base.logger = logger
Connection.connect environment:env
