json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :username, :email, :active, :author, :privileged, :story_id
  json.url user_url(user, format: :json)
end
