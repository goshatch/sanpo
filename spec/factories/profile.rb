FactoryGirl.define do
  factory :profile do
    user { FactoryGirl.create(:valid_user) }
  end
end
