class ApiController < ActionController::API
  def set_user
    api_key = request.headers['X-API-Key']
    binding.pry
    @user = User.find_by_token(api_key)
  end

  def validate_player
    render json: game, status: 401, message: "Unauthorized" unless set_user
  end
end
