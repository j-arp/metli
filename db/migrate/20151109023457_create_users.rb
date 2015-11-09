class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.boolean :active, default: true
      t.boolean :author, default: false
      t.boolean :privileged, default: false
      t.references :story, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
