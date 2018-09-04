require 'rails_helper'

describe ShipPlacer do
  let(:board) { Board.new(4) }
  let(:ship)  { double(length: 2) }
  subject     { ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2") }

  it "exists when provided a board and ship" do
    expect(subject).to be_a ShipPlacer
  end

  describe 'Instance Methods' do
    it "places the ship within a row with empty spaces" do
      a1 = board.locate_space("A1")
      a2 = board.locate_space("A2")
      a3 = board.locate_space("A3")
      b1 = board.locate_space("B1")

      expect(a1.contents).to be_nil
      expect(a2.contents).to be_nil
      expect(a3.contents).to be_nil
      expect(b1.contents).to be_nil

      subject.run

      expect(a1.contents).to eq(ship)
      expect(a2.contents).to eq(ship)
      expect(a3.contents).to be_nil
      expect(b1.contents).to be_nil
    end

    it "places the ship within a column with empty spaces" do
      a1 = board.locate_space("A1")
      b1 = board.locate_space("B1")

      neighbor_1 = board.locate_space("A2")
      neighbor_2 = board.locate_space("B2")

      expect(a1.contents).to be_nil
      expect(b1.contents).to be_nil
      expect(neighbor_1.contents).to be_nil
      expect(neighbor_2.contents).to be_nil

      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run

      expect(a1.contents).to eq(ship)
      expect(b1.contents).to eq(ship)
      expect(neighbor_1.contents).to be_nil
      expect(neighbor_2.contents).to be_nil
    end
  end

  it 'returns the correct message after placing a ship' do
    expect(subject.message(3)).to eq('Successfully placed ship with a size of 3. You have 2 ship(s) to place with a size of 2.')
    expect(subject.message(2)).to eq('Successfully placed ship with a size of 2. You have 2 ship(s) to place.')
  end

  describe 'Edge Cases' do
    it "doesn't place the ship if it isn't within the same row or column" do
      expect {
        ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B2").run
      }.to raise_error(StandardError)
    end

    it "doesn't place the ship if the space is occupied when placing in columns" do
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run
      expect {
        ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run
      }.to raise_error(StandardError)
    end

    it "doesn't place the ship if the space is occupied when placing in rows" do
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2").run
      expect {
        ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2").run
      }.to raise_error(StandardError)
    end

    it "doesn't place the ship if the ship is smaller than the supplied range in a row" do
      expect {
        ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A3").run
      }.to raise_error(StandardError)
    end

    it "doesn't place the ship if the ship is smaller than the supplied range in a column" do
      expect {
        ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "C1").run
      }.to raise_error(StandardError)
    end
  end
end
