require 'rails_helper'

describe Shooter, type: :model do
  it 'exists' do
    shooter = Shooter.new(board: Board.new(4), target: 'A1')

    expect(shooter).to be_a(Shooter)
  end

  describe 'Instance Methods' do
    context '#fire!' do
      it 'returns correct results hash for a shot that misses' do
        coordinates = 'A1'

        shooter = Shooter.new(board: Board.new(4), target: coordinates)

        expect(shooter.fire!).to eq(hit_or_miss: 'Miss')
      end

      it 'raises error when invalid coordinates are passed in' do
        coordinates = 'D5'

        shooter = Shooter.new(board: Board.new(4), target: coordinates)

        expect { shooter.fire! }.to raise_error(StandardError)
      end
    end
  end
end
