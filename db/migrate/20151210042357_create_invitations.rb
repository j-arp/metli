class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.text :message
      t.references :story, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
