class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :page
      t.text :settings_hash

      t.timestamps
    end
  end
end
