require 'rails_helper'

describe 'Api::V1::Games' do
  context('POST /api/v1/games') do
    it "creates a game" do
      create(:user, token: ENV['BATTLESHIFT_API_KEY'] )
      create(:user, token: ENV['BATTLESHIFT_OPPONENT_API_KEY'])

      post '/api/v1/games'

      expect(response).to be_successful

      game = JSON.parse(response.body, symbolize_names: true)

      expect(game[:id]).to eq(Game.last.id)
      expect(game[:message]).to eq(nil)
      expect(game[:current_turn]).to eq('Player 1')
      expect(game).to have_key(:player_1_board)
      expect(game).to have_key(:player_2_board)
      expect(game[:winner]).to eq(nil)
    end
  end
end
