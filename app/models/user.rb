class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :stories, through: :subscriptions

  validates :first_name, :last_name, :email, presence: true

  default_scope {order('last_name, first_name')}
  scope :active, -> { where(active:true) }
  scope :authors, -> { where(author:true) }
  scope :privileged, -> { where(privileged:true) }

  def to_s
    "#{first_name} #{last_name}"
  end

  def authored_stories
    stories = []
    s = subscriptions.where(author: true)
    s.each { |sub| stories << sub.story }
    return stories
  end

  def available_stories
    Story.all.where.not(id: stories)
  end

  def subscribe_to(story, username, options={})
    @options = {author: false, privileged: false}.merge(options)
    Subscription.create!(story:story, user: self, username: username,  author: @options[:author], privileged: @options[:privileged])
  end
end
