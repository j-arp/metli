json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :created_at
    json.date comment.created_at.strftime('%D')
    json.time comment.created_at.strftime('%r')
  json.user do
    json.full_name comment.user.full_name
    json.first_name comment.user.first_name
    json.last_name comment.user.last_name
    json.img comment.user.image
    json.name Subscription.find_by(story_id: @story.id, user_id: comment.user_id).username
    json.dbug comment.user_id
  end
end
