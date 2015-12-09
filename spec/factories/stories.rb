FactoryGirl.define do
  factory :story do
    name { Faker::Lorem.sentence }
    active true
    about "Fusce ac felis sit amet ligula pharetra condimentum. Proin viverra, ligula sit amet ultrices semper, ligula arcu tristique sapien, a accumsan nisi mauris ac eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed aliquam, nisi quis porttitor congue, elit erat euismod orci, ac placerat dolor lectus quis orci. Etiam rhoncus. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem."
    teaser "Aliquam erat volutpat. Vestibulum turpis sem, aliquet eget, lobortis pellentesque, rutrum eu, nisl. Nullam nulla eros, ultricies sit amet, nonummy id, imperdiet feugiat, pede."
    taxonomy "MyText"
  end

end
