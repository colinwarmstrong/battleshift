class Game < ApplicationRecord
  enum current_turn: ["challenger", "computer"]
  serialize :player_1_board
  serialize :player_2_board
  serialize :history, Array

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true
end
