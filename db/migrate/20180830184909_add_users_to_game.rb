class AddUsersToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :user_1_id, :integer
    add_column :games, :user_2_id, :integer
  end
end
