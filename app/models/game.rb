class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ["Player 1", "Player 2"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true
end
