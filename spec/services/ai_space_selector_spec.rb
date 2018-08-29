require 'rails_helper'

describe AiSpaceSelector, type: :service do
  it 'exists' do
    board = Board.new(4)

    ai_space_selector = AiSpaceSelector.new(board)

    expect(ai_space_selector).to be_a(AiSpaceSelector)
  end

  describe 'Instance Methods' do
    it '#fire!' do
      board = Board.new(4)

      ai_space_selector = AiSpaceSelector.new(board)

      response = ai_space_selector.fire!

      expect(response).to eq('Miss')
    end
  end
end
