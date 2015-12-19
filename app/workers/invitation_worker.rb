class InvitationWorker
  @queue = "mail_queue_#{Rails.env}".to_sym

  def self.perform(email_list, message, story_id, user_id)
    puts "send invites to #{email_list}"
    @story = Story.find(story_id)
    @user = User.find(user_id)

    email_list.each_line do | email |
      invitation = Invitation.create!(email: email.strip, message: message, story: @story, user: @user) unless @story.invitations.find_by(email: email.strip)
      NotifierMailer.invite(@story, email.strip, message).deliver_now if invitation
    end
  end
end
