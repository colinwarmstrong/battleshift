class Api::V1::Games::ShotsController < ApiController
  before_action :set_game, :validate_player, :validate_turn, :validate_coordinate, :validate_game

  def create
    turn_processor.run!

    render json: @game, message: turn_processor.message
  end

  private

  attr_reader :game

  def shot_params
    params.permit(:game_id, :target)
  end

  def set_game
    @game ||= Game.find(shot_params[:game_id])
  end

  def turn_processor
    @turn_processor ||= TurnProcessor.new(game, shot_params[:target])
  end

  def validate_turn
    user = set_user
    render json: game, status: 400, message: "Invalid move. It's your opponent's turn" unless correct_player?(user, game)
  end

  def correct_player?(user, game)
    user.token == ENV['BATTLESHIFT_API_KEY'] && game.current_turn == 'Player 1' || user.token == ENV['BATTLESHIFT_OPPONENT_API_KEY'] && game.current_turn == 'Player 2'
  end

  def validate_coordinate
    render json: game, status: 400, message: "Invalid coordinates" unless valid_coordinate?
  end

  def valid_coordinate?
    board.board.flatten.any? do |coordinate|
      coordinate.include?(shot_params[:target])
    end
  end

  def validate_game
   if game.winner != nil
      render json: game, status: 400, message: "Invalid move. Game over."
   end
  end

  def validate_player
    if set_user.nil?
      render json: game, status: 401, message: "Unauthorized"
    end
  end

  def board
    if game.current_turn == 'Player 1'
      game.player_1_board
    else
      game.player_2_board
    end
  end
end
