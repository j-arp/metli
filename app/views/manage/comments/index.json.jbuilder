json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :user_id, :chapter_id, :is_flagged
  json.url comment_url(comment, format: :json)
end
