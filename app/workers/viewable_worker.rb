class ViewableWorker
  @queue = "viewable_queue_#{Rails.env}".to_sym

  def self.perform(chapter_id,user_id)
      @chapter = Chapter.find(chapter_id)
      puts "preform!!! on #{@chapter}"
      @chapter.views.create(user_id: user_id)
  end
end
