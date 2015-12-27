class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by'
  validates :key, presence: true
  before_validation :generate_key

  def used?
    used
  end

  private

  def generate_key
    self.key = SecureRandom.hex(4)
  end

end
