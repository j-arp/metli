class SubscriptionDecorator < Draper::Decorator
  delegate_all


  def chapters
    self.story.chapters
  end

  def next_chapter
    last_number = last_read_chapter_number.nil? ? 0 : last_read_chapter_number
    self.story.chapters.published.where("number > ?", last_number).last
  end

  def last_chapter
    self.story.chapters.published.first
  end
end
