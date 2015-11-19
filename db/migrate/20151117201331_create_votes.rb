class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true
      t.string :votable_type
      t.string :votable_id

      t.timestamps null: false
    end
  end
end
