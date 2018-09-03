player_1_board = Board.new(4)
player_2_board = Board.new(4)

sm_ship = Ship.new(2)
md_ship = Ship.new(3)

user_1 = User.create!(email: "eliotswank@gmail.com", name: 'eliot', password: 'hamburger1', activated: true, token: ENV['BATTLESHIFT_API_KEY'])
user_2 = User.create!(email: "colinwarmstrong@gmail.com", name: 'Colin', password: 'password', activated: true, token: ENV['BATTLESHIFT_OPPONENT_API_KEY'])

# Place Player 1 ships
ShipPlacer.new(board: player_1_board,
               ship: sm_ship,
               start_space: "A1",
               end_space: "A2").run

ShipPlacer.new(board: player_1_board,
               ship: md_ship,
               start_space: "B1",
               end_space: "D1").run

# Place Player 2 ships
ShipPlacer.new(board: player_2_board,
               ship: sm_ship.dup,
               start_space: "A1",
               end_space: "A2").run

ShipPlacer.new(board: player_2_board,
               ship: md_ship.dup,
               start_space: "B1",
               end_space: "D1").run

game_attributes = {
  player_1_board: player_1_board,
  player_2_board: player_2_board,
  player_1_turns: 0,
  player_2_turns: 0,
  current_turn: 0,
  user_1_id: user_1.id,
  user_2_id: user_2.id
}

game = Game.new(game_attributes)
game.save!
