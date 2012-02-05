class Photo < ActiveRecord::Base
  belongs_to :walk

  has_attached_file :image, :styles => { :large => "620x620", :medium => "x200", :thumb => "64x64#" }
  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  validates_attachment_presence :image
end
