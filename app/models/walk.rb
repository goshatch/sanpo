class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :waypoints, :dependent => :destroy
  has_many :photos, :dependent => :destroy

  accepts_nested_attributes_for :waypoints

  def center_coordinates
    # TODO: This code kind of sucks
    start = waypoints.first
    goal = waypoints.last
    target_latitude = (start.latitude + goal.latitude) / 2
    target_longitude = (start.longitude + goal.longitude) / 2
    {:latitude => target_latitude, :longitude => target_longitude}
  end
end
