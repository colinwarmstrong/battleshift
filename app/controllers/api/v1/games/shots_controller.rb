class Api::V1::Games::ShotsController < ApiController
  def create
    game = Game.find(params[:game_id])

    turn_processor = TurnProcessor.new(game, params[:shot][:target])

    turn_processor.run!
    render json: game, message: turn_processor.message
  end
end
