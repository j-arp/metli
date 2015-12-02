class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :content
      t.references :call_to_action, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
