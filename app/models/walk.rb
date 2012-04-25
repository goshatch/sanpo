class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :waypoints, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :notes

  accepts_nested_attributes_for :waypoints

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode

  def to_param
    "#{id} #{title}".parameterize
  end

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

  def length_in_km
    if length < 1000
      "Less than 1 km"
    else
      "About #{length/1000} km"
    end
  end
end
