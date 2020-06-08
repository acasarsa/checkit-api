class FixUsersColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :name
    remove_column :users, :password
  end
end
