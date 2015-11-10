class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :story, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :author, default: false
      t.boolean :privileged, default: false
      t.boolean :active , default: true
      t.string :username

      t.timestamps null: false
    end
  end
end
