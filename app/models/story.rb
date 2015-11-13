class Story < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions, dependent: :destroy
  has_many :chapters, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :available_for, -> (user) { where.not(id: user.stories.map(&:id)) }

  has_permalink :name

  def to_s
    name
  end

end
