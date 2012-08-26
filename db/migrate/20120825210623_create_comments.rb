class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.string :name
      t.string :email
      t.integer :story_id
      t.integer :approved_by

      t.timestamps
    end
  end
end
