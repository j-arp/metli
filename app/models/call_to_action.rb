class CallToAction < ActiveRecord::Base
  belongs_to :chapter
  has_many :actions, dependent: :destroy

  def progress
    total_votes = chapter.votes.count
    total_voters = chapter.story.subscriptions.count
    if total_voters > 0
      percent = (total_votes.to_f / total_voters.to_f) * 100
    else
      percent =  0
    end

    return  percent.round

  end
end
