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

    render json: Game.create({player_1_board: board1, player_2_board: board2})
  end
end
