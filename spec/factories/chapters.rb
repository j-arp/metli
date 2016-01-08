FactoryGirl.define do
  factory :chapter do
    number 1
    story
    title "I am a new chapter!"
    content "My Text"
    published_on Time.now - 1 .day
    vote_ends_on DateTime.now + 1.day
    voting_ends_after '1 day'
    association :author, factory: :user, last_name: "McWriter", strategy: :create
  end

end
