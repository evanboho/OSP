class AddAdminIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :admin_id, :integer
  end
end
