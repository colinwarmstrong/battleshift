require 'rails_helper'

describe 'Api::V1::Ships' do
  context 'POST /api/v1/games/:id/ships' do
    let(:player_1_board)   { Board.new(4) }
    let(:player_2_board)   { Board.new(4) }
    let(:game)    {
      create(:game,
        player_1_board: player_1_board,
        player_2_board: player_2_board,
        user_1_id: create(:user, token: ENV['BATTLESHIFT_API_KEY'] ).id,
        user_2_id: create(:user, token: ENV['BATTLESHIFT_OPPONENT_API_KEY']).id
      )
    }

    it 'places a ship' do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => ENV['BATTLESHIFT_API_KEY'] }
      json_payload = {ship_size: 3, start_space: 'A1', end_space: 'A3', game_id: game.id}.to_json

      post "/api/v1/games/#{game.id}/ships", params: json_payload, headers: headers

      game_state = JSON.parse(response.body, symbolize_names: true)

      expect(game_state[:id]).to eq(Game.last.id)
      expect(game_state[:message]).to eq('Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.')
      expect(game_state[:current_turn]).to eq('Player 1')
      expect(game_state).to have_key(:player_1_board)
      expect(game_state).to have_key(:player_2_board)
      expect(game_state[:winner]).to eq(nil)

      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => ENV['BATTLESHIFT_API_KEY'] }
      json_payload = {ship_size: 2, start_space: 'B1', end_space: 'B2', game_id: game.id}.to_json

      post "/api/v1/games/#{game.id}/ships", params: json_payload, headers: headers

      game_state = JSON.parse(response.body, symbolize_names: true)

      expect(game_state[:id]).to eq(Game.last.id)
      expect(game_state[:message]).to eq('Successfully placed ship with a size of 2. You have 0 ship(s) to place.')
      expect(game_state[:current_turn]).to eq('Player 1')
      expect(game_state).to have_key(:player_1_board)
      expect(game_state).to have_key(:player_2_board)
      expect(game_state[:winner]).to eq(nil)
    end

    it 'raises StandardError if ship size does not match the distance between start and end spaces' do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => ENV['BATTLESHIFT_API_KEY'] }
      json_payload = {ship_size: 3, start_space: 'A1', end_space: 'A4', game_id: game.id}.to_json

      expect { post "/api/v1/games/#{game.id}/ships", params: json_payload, headers: headers }.to raise_error(StandardError)
    end

    it 'raises StandardError when attempting to place a ship in a space that is already occupied' do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => ENV['BATTLESHIFT_API_KEY'] }
      json_payload = {ship_size: 3, start_space: 'A1', end_space: 'A3', game_id: game.id}.to_json

      post "/api/v1/games/#{game.id}/ships", params: json_payload, headers: headers

      expect{ post "/api/v1/games/#{game.id}/ships", params: json_payload, headers: headers }.to raise_error(StandardError)
    end

    it 'raises StandardError when attempting to place a ship that is not in either the same row or column' do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-Key" => ENV['BATTLESHIFT_API_KEY'] }
      json_payload = {ship_size: 3, start_space: 'A1', end_space: 'B2', game_id: game.id}.to_json

      expect { post "/api/v1/games/#{game.id}/ships", params: json_payload, headers: headers }.to raise_error(StandardError)
    end
  end
end
