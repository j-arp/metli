class AddSentToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :sent, :boolean, default: false
    add_column :invites, :user_requested, :boolean, default: false
  end
end
