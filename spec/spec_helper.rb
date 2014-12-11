require File.expand_path('../../config/boot', __FILE__)
require 'rspec'


RSpec.configure do |config|
	config.mock_with :rspec

	# ermöglicht die Einschränkung der zu testenden Specs
	# durch  >>it "irgendwas", :focus => true do <<
	config.filter_run :focus => true
	config.run_all_when_everything_filtered = true

### to do : Enable DatabaseCleaner in NonRails-Environment
#	config.use_transactional_fixtures = false
#	config.before(:suite) do
#		DatabaseCleaner.strategy = :truncation
#
#	end
#	# Alternative: :all, dann wird die DB zwischen den Tests nicht resettet
#	config.before(:each) do
#		DatabaseCleaner.start
#	end
#	config.after(:each) do
#		DatabaseCleaner.clean
#	end


	config.order = "random"
end
