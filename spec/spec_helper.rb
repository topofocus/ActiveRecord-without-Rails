Env='test'
require File.expand_path('../../config/boot', __FILE__)
require 'rspec'
# require your own helper-files here
# require 'my_spec_helper'
require 'factory_girl'
require 'database_cleaner'
#load 'factories.rb'
FactoryGirl.find_definitions

RSpec.configure do |config|
	config.mock_with :rspec

	# ermöglicht die Einschränkung der zu testenden Specs
	# durch  >>it "irgendwas", :focus => true do <<
	config.filter_run :focus => true
	config.run_all_when_everything_filtered = true
	#
	config.include FactoryGirl::Syntax::Methods
	config.before(:suite) do
		begin
			DatabaseCleaner.strategy = :truncation
			DatabaseCleaner.start
			FactoryGirl.lint
		ensure
			DatabaseCleaner.clean
		end
	#	# Alternative: :all, dann wird die DB zwischen den Tests nicht resettet
	#	config.before(:each) do
	#		DatabaseCleaner.start
	#	end
	#	config.after(:each) do
	#		DatabaseCleaner.clean
	#	end
	end


	config.order = "random"
end
