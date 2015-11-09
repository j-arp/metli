json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :number, :title, :content, :published_on, :author_id, :story_id
  json.url chapter_url(chapter, format: :json)
end
