class Api::V1::GamesController < ActionController::API
  def show
    game = Game.find_by_id(game_params[:id])
    if game
      render json: game
    else
      render status: 400
    end
  end

  def create
    render json: Game.create(game_attributes)
  end

  private

  def game_params
    params.permit(:id, :opponent_email)
  end

  def game_attributes
    {player_1_board: Board.new(4),
     player_2_board: Board.new(4),
     user_1_id:      user_1.id,
     user_2_id:      user_2.id}
  end

  def user_1
    User.find_by_token(ENV['BATTLESHIFT_API_KEY'])
  end

  def user_2
    User.find_by_email(game_params[:opponent_email])
  end
end
