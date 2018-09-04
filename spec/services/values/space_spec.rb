require 'rails_helper'

describe Space, type: :service do
  let(:coordinates) { double('A1') }
  let(:space)       { Space.new(coordinates) }

  it 'exists' do
    expect(space).to be_a(Space)
  end

  it 'has attributes' do
    expect(space.coordinates).to eq(coordinates)
    expect(space.contents).to eq(nil)
    expect(space.status).to eq('Not Attacked')
  end

  describe 'Instance Methods' do
    it '#attack!' do
      expect(space.attack!).to eq('Miss')
      expect(space.status).to eq('Miss')
    end

    it '#occupy!' do
      expect(space.contents).to eq(nil)

      ship = Ship.new(2)

      space.occupy!(ship)

      expect(space.contents).to eq(ship)
    end

    it '#not_attacked?' do
      expect(space.not_attacked?).to eq(true)

      space.attack!

      expect(space.not_attacked?).to eq(false)
    end
  end
end
