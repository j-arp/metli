class Action < ActiveRecord::Base
  belongs_to :call_to_action
  has_many :votes, as: :votable, dependent: :destroy
end
