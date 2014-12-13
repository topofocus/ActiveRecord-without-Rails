#module Mylog
class MyLog
	require 'logger'
	
	 # Singleton to make active Logger universally accessible as Mylog::MyLog.logger
		class << self
			attr_accessor :logger
		end
#	attr_reader :logger

		def initialize filename:'hctw'
			project_root = File.expand_path('../..', __FILE__)
			self.logger = Logger.new( project_root+'/log/'+filename+'.log' ).tap do 
				|log|
				log.formatter = proc do |severity, datetime, progname, msg|
					"#{datetime.strftime("%d.%m.(%X)")}#{"%5s" % severity}->#{progname}##{msg}\n"
				end
			end

			MyLog.logger = self
		end # def
		
		def logger=  log
			@logger =  log
		end

		def log
			@logger
		end


end # class
#end # module
