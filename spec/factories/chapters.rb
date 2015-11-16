FactoryGirl.define do
  factory :chapter do
    number 1
    title { Faker::Lorem.sentence }
    content "My Text"
    published_on "2015-11-08"
    association :author, factory: :user, last_name: "McWriter", strategy: :create
    story
  end

end
