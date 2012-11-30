class User < ActiveRecord::Base
  has_many :walks, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  has_one :profile, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :generate_empty_profile

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login
  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}

  # Setup Geocoder
  geocoded_by :current_sign_in_ip

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :username, :login, :mail_comment_notification

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end

  def total_km_walked
    walks = self.walks
    total_m = 0
    walks.each do |walk|
      total_m += walk.length
    end
    total_m / 1000
  end

  private
  def generate_empty_profile
    profile = Profile.new
    profile.user = self
    profile.save
  end
end
