class Story < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions, dependent: :destroy
  has_many :chapters, dependent: :destroy
  has_many :invitations
  has_many :views, as: :viewable, dependent: :destroy

  belongs_to :user

  validates :name, :teaser, :user, presence: true
  validates :teaser, length: { maximum: 750 }
  validates :name, uniqueness: true


  scope :available_for, -> (user) { where(completed: false).where.not(id: user.stories.map(&:id)) }
  scope :by_activity, -> { order('updated_at desc') }
  scope :all_completed, -> { where(completed: true) }
  scope :recently_completed, -> { where(completed: true).where("updated_at > ?",  Time.now - 7.days) }
  scope :active_now, -> { where(active: true, completed: false) }
  scope :recently_completed_and_active, -> { Story.active_now + Story.recently_completed}

  scope :chronologically, -> {order('updated_at desc')}

  has_permalink :name

  def to_s
    name
  end

  def completed?
    return true if completed
    return false
  end

  def total_views
    totes = 0
    chapters.each { | c | totes += c.views.count }
    return totes
  end

  def total_votes
    totes = 0
    chapters.each { | c | totes += c.votes.count }
    return totes
  end

end
