class AddPhoneToStories < ActiveRecord::Migration
  def change
    add_column :stories, :phone, :string
  end
end
