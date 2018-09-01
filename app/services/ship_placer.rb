class ShipPlacer
  def initialize(attributes)
    @board       = attributes[:board]
    @ship        = attributes[:ship]
    @start_space = attributes[:start_space]
    @end_space   = attributes[:end_space]
  end

  def run
    if same_row?
      place_in_row
    elsif same_column?
      place_in_column
    else
      raise StandardError.new("Ship must be in either the same row or column.")
    end
  end

  def message(ship_length)
    if ship_length == 3
      "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
    elsif ship_length == 2
      "Successfully placed ship with a size of 2. You have 0 ship(s) to place."
    end
  end

  private

  attr_reader :board, :ship, :start_space, :end_space

  def same_row?
    start_space[0] == end_space[0]
  end

  def same_column?
    start_space[1] == end_space[1]
  end

  def place_in_row
    row = start_space[0]
    range = start_space[1]..end_space[1]
    raise StandardError.new("Invalid ship placement") unless range.count == ship.length
    range.each { |column| place_ship(row, column) }
  end

  def place_in_column
    column = start_space[1]
    range = start_space[0]..end_space[0]
    raise StandardError.new("Invalid ship placement") unless range.count == ship.length
    range.each { |row| place_ship(row, column) }
  end

  def place_ship(row, column)
    coordinates = "#{row}#{column}"
    space = board.locate_space(coordinates)
    if space.occupied?
      raise StandardError.new("Attempting to place ship in a space that is already occupied.")
    else
      space.occupy!(ship)
    end
  end
end
