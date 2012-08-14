class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.datetime :approved_at
      t.boolean :gender
      t.string :name
      t.integer :age

      t.timestamps
    end
  end
end
