FactoryGirl.define do
  factory :subscription do
    story
    user
    active true
    author false
    privileged false
    username { Faker::Internet.user_name }
  end

end
