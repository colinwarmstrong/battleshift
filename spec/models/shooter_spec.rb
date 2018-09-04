require 'rails_helper'

describe Shooter, type: :model do
  let(:board) { Board.new(4) }
  let(:shooter) { Shooter.new(board: board, target: 'A1') }

  it 'exists' do
    expect(shooter).to be_a(Shooter)
  end

  describe 'Instance Methods' do
    context '#fire!' do
      it 'returns a miss result' do
        expect(shooter.fire!).to eq(hit_or_miss: 'Miss')
      end

      it 'returns a hit result' do
        space = board.locate_space('A1')
        space.occupy!(Ship.new(2))

        expect(shooter.fire!).to eq(hit_or_miss: 'Hit')
      end

      it 'returns a sunken ship result' do
        ShipPlacer.new(board: board,
                       ship: Ship.new(2),
                       start_space: "A1",
                       end_space: "A2").run

        Shooter.new(board: board, target: 'A1').fire!
        shooter = Shooter.new(board: board, target: 'A2')

        expect(shooter.fire!).to eq(hit_or_miss: 'Hit', sunk: true)
      end
    end
  end

  describe 'Edge Cases' do
    it '#fire! raises a StandardError when invalid coordinates are passed in' do
      coordinates = 'D5'

      shooter = Shooter.new(board: Board.new(4), target: coordinates)

      expect { shooter.fire! }.to raise_error(StandardError)
    end
  end
end
