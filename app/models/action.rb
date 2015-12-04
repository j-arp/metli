class Action < ActiveRecord::Base
  belongs_to :call_to_action
  has_many :votes, as: :votable, dependent: :destroy

  def percent_of_vote
    parent_chapter = self.call_to_action.chapter
    total_votes = parent_chapter.votes.count
    return ( (votes.count.to_f / total_votes.to_f) * 100).round() if total_votes != 0
  end

end
