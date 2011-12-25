class Photo < ActiveRecord::Base
  belongs_to :walk

  has_attached_file :image, :styles => { :medium => "300x300", :thumb => "64x64" }
end
