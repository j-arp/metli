class CreateCallToActions < ActiveRecord::Migration
  def change
    create_table :call_to_actions do |t|
      t.string :call
      t.references :chapter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
