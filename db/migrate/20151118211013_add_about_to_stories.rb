class AddAboutToStories < ActiveRecord::Migration
  def change
    add_column :stories, :about, :text
  end
end
