class AddHistoryToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :history, :text
  end
end
