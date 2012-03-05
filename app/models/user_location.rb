class UserLocation < ActiveRecord::Base
  belongs_to :user
  geocoded_by :ip_address

  after_validation :geocode, :if => :ip_address_changed?
end
