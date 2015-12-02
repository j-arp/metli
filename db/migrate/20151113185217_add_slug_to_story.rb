class AddSlugToStory < ActiveRecord::Migration
  def change
    add_column :stories, :slug, :string
  end
end
