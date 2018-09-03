require 'rails_helper'

describe Board, type: :service do
  it 'exists' do
    board = Board.new(4)

    expect(board).to be_a(Board)
  end

  it 'has attributes' do
    length = 4

    board = Board.new(length)

    expect(board.ship_count).to eq(0)
    expect(board.length).to eq(length)
    expect(board.board).to be_an(Array)
    expect(board.board.length).to eq(4)
  end

  describe 'Instance Methods' do
    it '#get_row_letters' do
      board = Board.new(4)

      expect(board.get_row_letters).to eq(['A', 'B', 'C', 'D'])
    end

    it '#get_column_numbers' do
      board = Board.new(4)

      expect(board.get_column_numbers).to eq(['1', '2', '3', '4'])
    end

    it '#space_names' do
      board = Board.new(2)

      expect(board.space_names).to eq(['A1', 'A2', 'B1', 'B2'])
    end

    it '#create_spaces' do
      board = Board.new(4)

      expect(board.create_spaces).to be_a(Hash)
    end

    it '#assign_spaces_to_rows' do
      board = Board.new(2)

      expect(board.assign_spaces_to_rows).to eq([['A1', 'A2'], ['B1', 'B2']])
    end

    it '#create_grid' do
      board = Board.new(2)

      grid = board.create_grid

      expect(grid).to be_an(Array)
      expect(grid[0][0]).to have_key('A1')
      expect(grid[0][1]).to have_key('A2')
      expect(grid[1][0]).to have_key('B1')
      expect(grid[1][1]).to have_key('B2')
    end

    it '#locate_spaces()' do
      coordinates = 'A1'

      board = Board.new(2)

      board.create_grid

      space = board.locate_space(coordinates)

      expect(space).to be_a(Space)
      expect(space.coordinates).to eq(coordinates)
    end
  end
end
