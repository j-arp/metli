class AddTeaserToStories < ActiveRecord::Migration
  def change
    add_column :stories, :teaser, :text
  end
end
