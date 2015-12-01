class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.boolean :active, defalt: true
      t.text :taxonomy

      t.timestamps null: false
    end
  end
end
