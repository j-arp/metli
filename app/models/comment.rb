class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapter

  scope :newer, -> { order('created_at asc')}
  scope :older, -> { order('created_at desc')}

  validates :content, :user, :chapter, presence: true
end
