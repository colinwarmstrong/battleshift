class ApiController < ActionController::API
  def set_user
    api_key = request.headers['X-API-Key']
    @user = User.find_by_token(api_key)
  end
end
