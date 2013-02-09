FactoryGirl.define do
  factory :profile do
    user { FactoryGirl.create(:user) }
  end
end
