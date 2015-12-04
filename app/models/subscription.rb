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

end
