FactoryGirl.define do
  factory :chapter do
    number 1
    title { Faker::Lorem.sentence }
    content "My Text"
    published_on "2015-11-08"
    author
    story
  end

end
