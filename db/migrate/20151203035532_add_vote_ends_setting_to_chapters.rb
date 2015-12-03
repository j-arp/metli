class AddVoteEndsSettingToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :voting_ends_after, :string
  end
end
