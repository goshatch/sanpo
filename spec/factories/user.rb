FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@sanpo.cc.test"
  end
  sequence :username do |n|
    "user#{n}"
  end
  
  factory :valid_user, class: User do
    email { generate(:email) }
    username { generate(:username) }
    password "hogehoge"
    admin false
  end

  factory :invalid_name_user, class: User do
    email { generate(:email) }
    username { " " }
    password "jassadetsagerdu"
    admin false
  end

  factory :admin, class: User do
    email  "admin@sanpo.cc.test"
    username "admin"
    password "hogehoge"
    admin true
  end

end
