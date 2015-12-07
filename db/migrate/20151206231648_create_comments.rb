class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, index: true, foreign_key: true
      t.references :chapter, index: true, foreign_key: true
      t.boolean :is_flagged

      t.timestamps null: false
    end
  end
end
