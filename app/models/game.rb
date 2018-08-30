class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ["Player 1", "Player 2"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  belongs_to :user_1, class_name: "User", foreign_key: "user_1_id"
  belongs_to :user_2, class_name: "User", foreign_key: "user_2_id"
end
