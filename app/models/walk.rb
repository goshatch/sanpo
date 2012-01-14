class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :waypoints, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :notes

  accepts_nested_attributes_for :waypoints

  def center_coordinates
    # TODO: This code kind of sucks
    start = waypoints.first
    goal = waypoints.last
    target_latitude = (start.latitude + goal.latitude) / 2
    target_longitude = (start.longitude + goal.longitude) / 2
    {:latitude => target_latitude, :longitude => target_longitude}
  end

  def formatted_description
    description.gsub(/\n/, '<br/>')
  end

  def formatted_notes
    notes.gsub(/\n/, '<br/>')
  end
end
