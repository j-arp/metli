FactoryGirl.define do
  factory :story do
    name { Faker::Lorem.sentence }
    active true
    taxonomy "MyText"
  end

end
