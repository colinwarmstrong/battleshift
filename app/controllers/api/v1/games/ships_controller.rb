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
    @instance_options[:message] = "Successfully placed ship with a size of #{ship_params[:ship_size]}. You have #{ship_params[:ship_size -1]} ship(s) to place with a size of 2."
    render json: game, serializer: GameSerializer(@instance_options)

  end

  private

  def ship_params
    params.permit(:ship_size, :damage, :start_space, :end_space, :game_id)
  end
end