FactoryGirl.define do
  factory :comment do
    text "This is the best!"
    user { FactoryGirl.create(:valid_user) }
    walk { FactoryGirl.create(:walk) }
  end
end
