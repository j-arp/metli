class Subscription < ActiveRecord::Base
  belongs_to :story
  belongs_to :user

  validates :username, :story, :user, presence: true
  validates :username, uniqueness: {scope: :story}

  scope :available, -> (user) {where.not(user.stories)}

  def active?
    active
  end

  def privileged?
    privileged
  end

  def author?
    author
  end

  def allow_voting_for?(chapter)
    return false if chapter.votes.select { | v | v.user_id == user.id }.present?
    return false if (chapter.vote_ends_on) < (DateTime.now)
    return true
  end

end
