module Api
  module V1
    class GamesController < ActionController::API
      def show
        render json: Game.find(:id)
      end
    end
  end
end
