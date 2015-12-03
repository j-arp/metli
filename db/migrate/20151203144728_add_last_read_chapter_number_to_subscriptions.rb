class AddLastReadChapterNumberToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_read_chapter_number, :integer
  end
end
