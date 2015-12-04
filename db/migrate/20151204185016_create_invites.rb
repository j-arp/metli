class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites, :force => true do |t|
      t.string :key
      t.boolean :used, default: false
      t.references :user, index: true, foreign_key: true
      t.datetime :used_on

      t.timestamps null: false
    end
  end
end
