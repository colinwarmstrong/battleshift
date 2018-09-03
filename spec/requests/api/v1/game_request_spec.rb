require 'rails_helper'

describe 'Games API' do
  it "sends a success status in json" do
    create(:user, token: ENV['BATTLESHIFT_API_KEY'] )
    create(:user, token: ENV['BATTLESHIFT_OPPONENT_API_KEY'])

    post '/api/v1/games'

    expect(response).to be_successful
  end

  it "can build a board" do
    
  end
end
