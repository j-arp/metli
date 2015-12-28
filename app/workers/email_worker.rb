class EmailWorker
  @queue = "mail_queue_#{Rails.env}".to_sym

  def self.perform(mailable)
    mailable.deliver_now
  end
end
