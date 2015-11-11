class Story < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :chapters
  validates :name, presence: true
  validates :name, uniqueness: true

  scope :available_for, -> (user) { where.not(id: user.stories.map(&:id)) }

  def to_s
    name
  end

end
