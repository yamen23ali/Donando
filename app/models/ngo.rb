class Ngo < ActiveRecord::Base

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	has_many :demands
end
