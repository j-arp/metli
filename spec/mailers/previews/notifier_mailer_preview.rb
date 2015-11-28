# Preview all emails at http://localhost:3000/rails/mailers/notifier_mailer
class NotifierMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifier_mailer/welcome
  def welcome
    NotifierMailer.welcome
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifier_mailer/new_chapter
  def new_chapter
    NotifierMailer.new_chapter
  end

end
