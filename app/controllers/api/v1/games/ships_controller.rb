class Api::V1::Games::ShipsController < ApiController
  def create
    @user = set_user
    @game ||= Game.find(ship_params[:game_id])
    ship_placer.run
    @game.save

    render json: @game, message: ship_placer.message(ship_params[:ship_size])
  end

  private

  attr_reader :user, :game

  def ship_params
    params.permit(:ship_size, :start_space, :end_space, :game_id)
  end

  def ship_placer
    @ship_placer ||= ShipPlacer.new(ship_placer_attributes)
  end

  def ship_placer_attributes
    {board:       set_board(user, game),
     ship:        Ship.new(ship_params[:ship_size]),
     start_space: ship_params[:start_space],
     end_space:   ship_params[:end_space]}
  end
end
