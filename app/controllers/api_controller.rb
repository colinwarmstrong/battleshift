class ApiController < ActionController::API
  def set_user
    api_key = request.headers['X-API-Key']
    @current_user ||= User.find_by_token(api_key)
  end

  def set_board(user, game)
    if user.token == ENV['BATTLESHIFT_API_KEY']
      game.player_1_board
    else
      game.player_2_board
    end
  end
end
