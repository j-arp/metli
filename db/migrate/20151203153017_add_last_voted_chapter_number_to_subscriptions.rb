class AddLastVotedChapterNumberToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_voted_chapter_number, :integer
  end
end
