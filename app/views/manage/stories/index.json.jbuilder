json.array!(@stories) do |story|
  json.extract! story, :id, :name, :active, :taxonomy
  json.url story_url(story, format: :json)
end
