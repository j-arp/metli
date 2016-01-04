class InvitationWorker
  @queue = "mail_queue_#{Rails.env}".to_sym

  def self.perform(email, message, story_id, user_id)
    @story = Story.find(story_id)
    @user = User.find(user_id)

      invitation = Invitation.create!(email: email.strip, message: message, story: @story, user: @user)
      NotifierMailer.invite(@story, email.strip, message).deliver if invitation

  end
end
