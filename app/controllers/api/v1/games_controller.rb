class Api::V1::GamesController < ActionController::API
  def show
    game = Game.find_by_id(params[:id])
    if game
      render json: game
    else
      render status: 400
    end
  end

  def create
    board1 = Board.new(4)
    board2 = Board.new(4)
    user_1 = User.find_by_token(ENV['BATTLESHIFT_API_KEY'])
    user_2 = User.find_by_token(ENV['BATTLESHIFT_OPPONENT_API_KEY'])
    render json: Game.create!({player_1_board: board1, player_2_board: board2, user_1_id: user_1.id, user_2_id: user_2.id})
  end
end
