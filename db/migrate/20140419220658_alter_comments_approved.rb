class AlterCommentsApproved < ActiveRecord::Migration
  def change

    add_column :comments, :approved_at, :string
    add_column :stories, :approved_by, :string
    reversible do |dir|
      dir.up { Story.all.each { |story| story.update(approved_by: story.admin_id) }}
      dir.down { Story.all.each { |story| story.update(admin_id: story.approved_by) }}
    end
    remove_column :stories, :admin_id
  end
end
