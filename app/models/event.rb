class Event < ApplicationRecord
	def self.search_by(search_term)
		where("LOWER(event_name) LIKE :search_term OR LOWER(event_description) LIKE :search_term OR LOWER(city) LIKE :search_term OR cast(start_date as text) LIKE :search_term OR cast(end_date as text) LIKE :search_term ",search_term: "%#{search_term.downcase}%")
	end
	def self.eventname(event_name)
		where("LOWER(event_name) LIKE :event_name",event_name: "%#{event_name.downcase}%")
	end
	def self.eventdescription(event_description)
		where("LOWER(event_description) LIKE :event_description",event_description: "%#{event_description.downcase}%")
	end
	def self.startdate(start_date)
		where("cast(start_date as text) LIKE :start_date",start_date: "%#{start_date.downcase}%")
	end
	def self.enddate(end_date)
		where("cast(end_date as text) LIKE :end_date",end_date: "%#{end_date.downcase}%")
	end
	def self.city(city)
		where("LOWER(city) LIKE :city",city: "%#{city.downcase}%")
	end
	belongs_to :user
	validate :end_date_after_start_date?

	def end_date_after_start_date?
		if end_date < start_date
			errors.add :end_date, "must be after start date"
		end
	end
end


