FactoryGirl.define do
  factory :walk do
    title "Best View Evar"
    description  "The best view at night in Tokyo."
    notes "Chicago pizza is so filling, better bring an empty stomach."
    user { FactoryGirl.create(:valid_user) }
  end
end
