class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapter

  validates :content, :user, :chapter, presence: true
end
