class Event < ApplicationRecord
	def self.search(search)
		if search
			where(["event_name LIKE ?","%#{search}%"])
		else
			all
		end
	end
	belongs_to :user
end


