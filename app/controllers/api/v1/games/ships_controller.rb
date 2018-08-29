class Api::V1::Games::ShipsController < ApiController

  def create
    game = Game.find(ship_params[:game_id])
    game.current_turn = 0
    board = game.player_1_board
    ship = Ship.new(ship_params[:ship_size])
    start_space = ship_params[:start_space]
    end_space = ship_params[:end_space]
    ship_placer = ShipPlacer.new(board, ship, start_space, end_space)
    ship_placer.run
    # binding.pry
    render json: game, status: 200, message: ship_placer.message(ship_params[:ship_size])
  end
  private

  # def ship_count
  #   count = ship_params[]
  # end

  def ship_params
    params.permit(:ship_size, :damage, :start_space, :end_space, :game_id)
  end
end