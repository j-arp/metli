class Chapter < ActiveRecord::Base
  belongs_to :author
  belongs_to :story

  validates :title, :content, :story, :author, presence: true

  def to_s
    title
  end


end
