FactoryGirl.define do
  factory :user_location do
    ip_address "46.246.120.226"
    user { FactoryGirl.create(:user) }
  end
end
