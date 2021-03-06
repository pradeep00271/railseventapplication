class Event < ApplicationRecord
	def self.search_by(search_term)
		where("LOWER(event_name) LIKE :search_term OR LOWER(event_description) LIKE :search_term OR LOWER(city) LIKE :search_term OR LOWER(start_date) LIKE :search_term OR LOWER(end_date) LIKE :search_term ",search_term: "%#{search_term.downcase}%")
	end

	belongs_to :user
end


