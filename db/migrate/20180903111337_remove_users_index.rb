class RemoveUsersIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :username
    remove_index :users, :email
  end
end
