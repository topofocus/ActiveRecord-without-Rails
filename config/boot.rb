require 'bundler/setup'
require 'logger'
require 'active_record'

# add the lib/spec directories just like autotest does
#$:.unshift File.expand_path('./models')
#$:.unshift File.expand_path('./lib')
#$:.unshift File.expand_path('./spec')

# require all the models and libraries
project_root = File.expand_path('../..', __FILE__)
logger = Logger.new project_root+'/log/no_rails.log'
models= Dir.glob(File.join( project_root, "models",'**', "*rb")) 
result =  models.collect { |file| [file, require( file )] }
libs= Dir.glob(File.join( project_root, "lib",'**', "*rb")) 
result << libs.collect { |file| [file, require( file )] }

logger.datetime_format = '%d.%m %H:%M:%S'
logger.formatter = proc do |severity, datetime, progname, msg|
	  "#{datetime.strftime("%d.%m.(%X)")}#{severity}-> #{progname} :..: #{msg}\n"
end
logger.progname = 'boot'
logger.sev_threshold = Logger::DEBUG  # WARN  # INFO # ERROR # FATAL

logger.debug{ "unsuccessfully required files: #{result.collect{|f,s| f if s.nil?}.compact.join(';')} " }
# open a connection to the db
#require File.expand_path('../../lib/connection', __FILE__)
e=  ARGV.size > 1 ? ARGV.last.downcase : 'development'
env = if e =~ /^p/
		      'production'
	      else
		      'development'
	      end

Connection.connect environment:env
