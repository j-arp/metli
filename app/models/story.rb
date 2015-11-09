class Story < ActiveRecord::Base
  has_many :users
  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end

end
