class Event < ApplicationRecord
	def self.search_by(search_term)
		where("LOWER(event_name) LIKE :search_term OR LOWER(event_description) LIKE :search_term OR LOWER(city) LIKE :search_term OR cast(start_date as text) LIKE :search_term OR cast(end_date as text) LIKE :search_term ",search_term: "%#{search_term.downcase}%")
	end
	def self.event_name(event_name)
		where("LOWER(event_name) LIKE :event_name",event_name: "%#{event_name.downcase}%")
	end
	def self.event_description(event_description)
		where("LOWER(event_description) LIKE :event_description",event_description: "%#{event_description.downcase}%")
	end
	def self.start_date(start_date)
		where("start_date LIKE :start_date",start_date: "%#{start_date.downcase}%")
	end
	def self.end_date(end_date)
		where("end_date LIKE :end_date",end_date: "%#{end_date.downcase}%")
	end
	def self.city(city)
		where("LOWER(city) LIKE :city",city: "%#{city.downcase}%")
	end
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :users, through: :comments
	mount_uploader :image, ImageUploader
	validates :image, file_size: {less_than: 5.megabytes}
	validate :end_date_after_start_date?

	scope :expired_events, -> { where('end_date < ?', Date.current) }
	after_save_commit :delete_expired_events


	def delete_expired_events
		DeleteExpiredEventsJob.perform_later

	end

	def end_date_after_start_date?
		if end_date < start_date
			errors.add :end_date, "must be after start date"
		end
	end
end


