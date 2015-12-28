class NotifierMailer < ApplicationMailer
  include Resque::Mailer

  default from: "whatnextapp@arpcentral.net"

  def welcome(user_id)
     @user = User.find(user_id)
     mail(to: @user.email, bcc: 'whatnextapp@arpcentral.net',  subject: "Welcome to 'What Next?' The Worlds first and only Choose-Our_Adventur Web App.")
  end

  def new_chapter(chapter_id, user_id)
    @chapter = Chapter.find(chapter_id)
    @user = User.find(user_id)
      mail(to: @user.email, bcc: 'whatnextapp@arpcentral.net',  subject: "New Chapter for '#{@chapter.story.name}' has been published!")
  end

  def voting_completed(chapter_id, author_id)
    @chapter = Chapter.find(chapter_id)
    @author = User.find(author_id)
      mail(to: @author.email, bcc: 'whatnextapp@arpcentral.net',  subject: "Voting has been completed for  '#{@chapter.story.name}'.")
  end

  def vote_happened(chapter_id, author_id)
    @chapter = Chapter.find(chapter_id)
    @author = User.find(author_id)
      mail(to: @author.email, bcc: 'whatnextapp@arpcentral.net',  subject: "A vote was cast for  '#{@chapter.story.name}'.")
  end

  def invite(story_id, email, message)
    @story = Story.find(story_id)
    @message = message
      mail(to: email, bcc: 'whatnextapp@arpcentral.net',  subject: "You have been invited to join a story on 'What Next?'")
  end

end
