class Subscription < ActiveRecord::Base
  belongs_to :story
  belongs_to :user

  validates :username, :story, :user, presence: true
  validates :username, uniqueness: {scope: :story}

  scope :avilable, -> (user) {where.not(user.stories)}

  def active?
    active
  end

  def privileged?
    privileged
  end

  def author?
    author
  end

  def next_chapter
    story.chapters.published.where("number > ?", last_read_chapter_number).first
  end

end
