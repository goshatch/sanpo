class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :locations
  has_many :photos
end
