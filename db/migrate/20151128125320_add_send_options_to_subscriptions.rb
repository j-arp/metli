class AddSendOptionsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :send_email, :boolean, default: false
    add_column :subscriptions, :send_push, :boolean, default: false
  end
end
