class AddCreatedByToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :created_by, :integer
  end
end
