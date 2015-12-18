class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.string :viewable_type
      t.integer :viewable_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
