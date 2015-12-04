class Invite < ActiveRecord::Base
  belongs_to :user
  validates :key, presence: true
  before_validation :generate_key

  private
  #
  def generate_key
    self.key = SecureRandom.hex(4)
  end

end
