class AddFirstNameAndLastNameToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :firstname, :string
    add_column :admins, :lastname, :string
  end
end
