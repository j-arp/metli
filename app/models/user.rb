class User < ActiveRecord::Base
  belongs_to :story

  validates :username, :first_name, :last_name, :email, :story, presence: true
  validates :username, uniqueness: true

  def to_s
    username
  end
end
