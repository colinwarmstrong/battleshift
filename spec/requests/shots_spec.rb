require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    let(:board)   { Board.new(4) }
    let(:sm_ship) { Ship.new(2) }
    let(:md_ship) { Ship.new(3) }
    let(:game)    {
      create(:game,
        player_1_board: board,
        player_2_board: board.dup,
      )
    }

    it "updates the messages with a hit" do
      allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")
      ShipPlacer.new(board: board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run

      ShipPlacer.new(board: board,
                     ship: md_ship,
                     start_space: "B1",
                     end_space: "D1").run

      headers = { "CONTENT_TYPE" => "application/json" }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_history = [
        [
          {player_1: "Shot resulted in a Hit"},
          {player_2: "Shot resulted in a Miss"}
        ]
      ]

      expect(game[:history]).to eq expected_history
    end
  end
end
