FactoryGirl.define do
  factory :photo do
    image "xxx"
    image_file_name  "xxx.jpg"
    walk { FactoryGirl.create(:walk) }
  end
end