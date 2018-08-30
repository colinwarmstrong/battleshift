class Api::V1::Games::ShipsController < ApiController
  def create
    user = set_user
    @game ||= Game.find(ship_params[:game_id])
    @game.current_turn = 0
    board = set_board(user, @game)
    ship = Ship.new(ship_params[:ship_size])
    start_space = ship_params[:start_space]
    end_space = ship_params[:end_space]
    @ship_placer ||= ShipPlacer.new(board: board, ship: ship, start_space: start_space, end_space: end_space)
    @ship_placer.run
    @game.save!
    render json: @game, message: @ship_placer.message(ship_params[:ship_size])
  end

  private

  def ship_params
    params.permit(:ship_size, :damage, :start_space, :end_space, :game_id)
  end
end
