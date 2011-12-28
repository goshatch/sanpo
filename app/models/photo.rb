class Photo < ActiveRecord::Base
  belongs_to :walk

  has_attached_file :image, :styles => { :large => "600x600", :medium => "x200", :thumb => "64x64#" }
end
