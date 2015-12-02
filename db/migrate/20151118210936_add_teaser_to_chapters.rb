class AddTeaserToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :teaser, :text
  end
end
