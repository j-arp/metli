class AddVoteEndDateToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :vote_ends_on, :datetime
  end
end
