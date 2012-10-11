class Profile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar, :styles => { :large => "128x128", :thumb => "48x48#" }
  validates_attachment_size :avatar, :less_than => 2.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  #validates_attachment_presence :avatar
end
