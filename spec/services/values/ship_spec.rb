require 'rails_helper'

describe Ship, type: :service do
  it 'exists' do
    ship = Ship.new(2)

    expect(ship).to be_a(Ship)
  end

  it 'has attributes' do
    ship = Ship.new(2)

    expect(ship.length).to eq(2)
    expect(ship.damage).to eq(0)
    expect(ship.start_space).to eq(nil)
    expect(ship.end_space).to eq(nil)
  end

  describe 'Instance Methods' do
    it '#place' do
      ship = Ship.new(4)

      start_space = 'A1'
      end_space = 'A2'

      ship.place(start_space, end_space)

      expect(ship.start_space).to eq(start_space)
      expect(ship.end_space).to eq(end_space)
    end

    it '#attack!' do
      ship = Ship.new(3)

      expect(ship.damage).to eq(0)

      ship.attack!

      expect(ship.damage).to eq(1)

      ship.attack!

      expect(ship.damage).to eq(2)
    end

    it '#is_sunk?' do
      ship = Ship.new(2)

      expect(ship.is_sunk?).to be(false)

      ship.attack!

      expect(ship.is_sunk?).to be(false)

      ship.attack!

      expect(ship.is_sunk?).to be(true)    
    end
  end
end
