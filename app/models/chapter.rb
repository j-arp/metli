class Chapter < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :story, touch: true
  has_one :call_to_action, dependent: :destroy
  has_many :actions, through: :call_to_action, dependent: :destroy

  before_create :auto_increment_chapter_number

  validates :title, :content, :story, :author, presence: true

  default_scope { order('created_at DESC') }

  def to_s
    title
  end

  def published?
    published_on.present?
  end

  def unpublish?
    return true if story.chapters.where.not(published_on: nil).where('number > ?', number).count == 0
    return false
  end

  def auto_increment_chapter_number
    self.number = 1 if story.chapters.empty?
    self.number = (story.chapters.last.number += 1) unless  story.chapters.empty?
  end

  def has_user_voted?(user_id)
    actions.joins(:votes).where('votes.user_id = ?', user_id).present?
  end
end
