class AddAlertOnVoteToStories < ActiveRecord::Migration
  def change
    add_column :stories, :alert_on_vote, :boolean
  end
end
