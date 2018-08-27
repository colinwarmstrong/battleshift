module Api
  module V1
    class GamesController < ActionController::API
      def show
        if Game.find_by_id(params[:id])
          game = Game.find(params[:id])
          render json: game
        else
          render status: 400
        end
      end
    end
  end
end
