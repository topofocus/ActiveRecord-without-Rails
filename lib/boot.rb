require 'bundler/setup'
require 'active_record'

# add the lib/spec directories just like autotest does
$:.unshift File.expand_path('./lib')
$:.unshift File.expand_path('./spec')

# require all the models
Dir.glob("models/*") { |file| require file }

# open a connection to the db
require 'lib/connection'
Connection.connect