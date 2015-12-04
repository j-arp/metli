json.array!(@invites) do |invite|
  json.extract! invite, :id, :key, :used, :user_id, :used_on
  json.url invite_url(invite, format: :json)
end
