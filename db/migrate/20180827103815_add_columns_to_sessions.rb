class AddColumnsToSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :sessions, :token, :string
    add_column :sessions, :user_id, :integer
    add_index :sessions, :user_id
  end
end
