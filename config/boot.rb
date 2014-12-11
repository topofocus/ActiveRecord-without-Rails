require 'bundler/setup'
require 'active_record'

# add the lib/spec directories just like autotest does
#$:.unshift File.expand_path('./models')
#$:.unshift File.expand_path('./lib')
#$:.unshift File.expand_path('./spec')

# require all the models and libraries
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(File.join( project_root, "models",'**', "*rb")) { |file| require file }
Dir.glob(File.join( project_root, "lib",'**', "*rb")) { |file| require file }

# open a connection to the db
require File.expand_path('../../lib/connection', __FILE__)

Connection.connect
