class NotifierMailer < ApplicationMailer
  default from: "whatnext@arpcentral.net"

  def welcome(user_id)
     @user = User.find(user_id)
     mail(to: @user.email, bcc: 'whatnext@arpcentral.net',  subject: "Welcome to 'What Next?' The Worlds first and only Choose-Our_Adventur Web App.")
  end

  def new_chapter(chapter, user)
    @chapter = chapter
    @user = user
      mail(to: @user.email, bcc: 'whatnext@arpcentral.net',  subject: "New Chapter for '#{@chapter.story.name}' has been published!")
  end

  def voting_completed(chapter, author)
    @chapter = chapter
    @author = author
      mail(to: @author.email, bcc: 'whatnext@arpcentral.net',  subject: "Voting has been completed for  '#{@chapter.story.name}'.")
  end

  def vote_happened(chapter, author)
    @chapter = chapter
    @author = author
      mail(to: @author.email, bcc: 'whatnext@arpcentral.net',  subject: "A vote was cast for  '#{@chapter.story.name}'.")
  end

  def invite(story, email, message)
    @story = story
    @message = message
      mail(to: email, bcc: 'whatnext@arpcentral.net',  subject: "You have been invited to join a story on 'What Next?'")
  end

end
