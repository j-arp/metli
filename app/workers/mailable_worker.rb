class MailWorker
  @queue = "mail_queue_#{Rails.env}".to_sym

  def self.perform(to, from, subject, message, cc=nil, bcc=nil  )
    puts "sending #{method} to Notifier with args of #{args}"
    NotifierMailer.send(method, args).deliver_now
  end
end
