class Chapter < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :story, touch: true
  before_create :auto_increment_chapter_number

  validates :title, :content, :story, :author, presence: true

  def to_s
    title
  end

  def auto_increment_chapter_number
    self.number = 1 if story.chapters.empty?
    self.number = (story.chapters.last.number += 1) unless  story.chapters.empty?
  end


end
