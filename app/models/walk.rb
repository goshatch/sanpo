class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :locations
  has_many :photos

  def center_coordinates
    start = locations.first
    goal = locations.last
    target_latitude = (start.latitude + goal.latitude) / 2
    target_longitude = (start.longitude + goal.longitude) / 2
    {:latitude => target_latitude, :longitude => target_longitude}
  end
end
