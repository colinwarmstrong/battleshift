class Api::V1::Games::ShotsController < ApiController
  before_action :validate_player, :validate_turn, :validate_coordinate, :validate_game

  def create
    game = Game.find(params[:game_id])
    user = set_user
    turn_processor = TurnProcessor.new(game, params[:shot][:target])
    turn_processor.run!
    set_turn(game)
    game.save!

    render json: game, message: turn_processor.message
  end

  private

  def validate_turn
    game = Game.find(params[:game_id])
    user = set_user
    render json: game, status: 400, message: "Invalid move. It's your opponent's turn" unless correct_player?(user, game)
  end

  def correct_player?(user, game)
    user.token == ENV['BATTLESHIFT_API_KEY']  && game.current_turn == 'Player 1' || user.token == ENV['BATTLESHIFT_OPPONENT_API_KEY'] && game.current_turn == 'Player 2'
  end

  def validate_coordinate
    game = Game.find(params[:game_id])
    render json: game, status: 400, message: "Invalid coordinates" unless valid_coordinate?
  end

  def valid_coordinate?
    board.board.flatten.any? do |coordinate|
      coordinate.include?(params[:shot][:target])
    end
  end

  def validate_game
    game = Game.find(params[:game_id])
   if game.winner != nil
      render json: game, status: 400, message: "Invalid move. Game over."
   end
  end

  def validate_player
    game = Game.find(params[:game_id])
    if set_user.nil?
      render json: game, status: 401, message: "Unauthorized"
    end
  end

  def board
    game = Game.find(params[:game_id])
    if game.current_turn == 'Player 1'
      game.player_1_board
    else
      game.player_2_board
    end
  end
end
