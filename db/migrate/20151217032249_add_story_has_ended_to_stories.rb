class AddStoryHasEndedToStories < ActiveRecord::Migration
  def change
    add_column :stories, :completed, :boolean, default: false
  end
end
