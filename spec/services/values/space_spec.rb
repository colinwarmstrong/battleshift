require 'rails_helper'

describe Space, type: :service do
  it 'exists' do
    coordinates = 'A1'

    space = Space.new(coordinates)

    expect(space).to be_a(Space)
  end

  it 'has attributes' do
    coordinates = 'A1'

    space = Space.new(coordinates)

    expect(space.coordinates).to eq(coordinates)
    expect(space.contents).to eq(nil)
    expect(space.status).to eq('Not Attacked')
  end

  describe 'Instance Methods' do
    it '#attack!' do
      coordinates = 'A1'
      space = Space.new(coordinates)

      expect(space.attack!).to eq('Miss')
      expect(space.status).to eq('Miss')
    end

    it '#occupy!' do
      ship = Ship.new(4)
      coordinates = 'A1'
      space = Space.new(coordinates)

      expect(space.contents).to eq(nil)

      space.occupy!(ship)

      expect(space.contents).to eq(ship)
    end

    it '#not_attacked?' do
      coordinates = 'A1'
      space = Space.new(coordinates)

      expect(space.not_attacked?).to eq(true)

      space.attack!

      expect(space.not_attacked?).to eq(false)
    end
  end
end
