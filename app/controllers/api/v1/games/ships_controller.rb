class Api::V1::Games::ShipsController < ApiController
  def create
    render json: Ship.new(5)
  end
end