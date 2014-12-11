class Page < ActiveRecord::Base

	def total
		Page.count
	end
end
