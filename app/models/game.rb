class Game < ApplicationRecord
  validates_presence_of :player_1_board
  validates_presence_of :player_2_board

  belongs_to :user_1, class_name: "User", foreign_key: "user_1_id"
  belongs_to :user_2, class_name: "User", foreign_key: "user_2_id"

  enum current_turn: ["Player 1", "Player 2"]

  serialize :player_1_board
  serialize :player_2_board
end
