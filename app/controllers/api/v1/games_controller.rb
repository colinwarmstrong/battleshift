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
    
  end
end
