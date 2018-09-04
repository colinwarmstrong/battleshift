require 'rails_helper'

describe TurnProcessor, type: :service do
  let(:user_1)         { create(:user, token: ENV['BATTLESHIFT_API_KEY']) }
  let(:user_2)         { create(:user, token: ENV['BATTLESHIFT_OPPONENT_API_KEY']) }
  let(:board_1)        { Board.new(4) }
  let(:board_2)        { Board.new(4) }
  let(:target)         { 'A1' }
  let(:game)           { Game.create(player_1_board: board_1, player_2_board: board_2, user_1_id: user_1.id, user_2_id: user_2.id) }
  let(:turn_processor) { TurnProcessor.new(game, target) }

  it 'exists' do
    expect(turn_processor).to be_a(TurnProcessor)
  end

  describe 'Instance Methods' do
    context('#run!') do
      it 'returns correct message for player 1 and changes current turn to player 2' do
        turn_processor.run!

        expect(turn_processor.message).to eq('Your shot resulted in a Miss. Game over.')
        expect(game.current_turn).to eq('Player 2')
      end

      it 'returns correct message for player 2 and changes current turn to player 1' do
        game.current_turn = 'Player 2'

        turn_processor.run!

        expect(turn_processor.message).to eq('Your shot resulted in a Miss. Game over.')
        expect(game.current_turn).to eq('Player 1')
      end

      it 'raises a StandardError when given invalid coordinates' do
        target = 'D5'
        turn_processor = TurnProcessor.new(game, target)

        expect { turn_processor.run! }.to raise_error(StandardError)
      end
    end
  end
end
