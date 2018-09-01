class Shooter
  def initialize(attributes = {})
    @board  = attributes[:board]
    @target = attributes[:target]
  end

  def fire!
    result = {}
    if valid_shot?
      result[:hit_or_miss] = space.attack!
      if space.contents && space.contents.is_sunk?
        result[:sunk] = true
        @board.ship_count -= 1
      end
      result
    else
      raise StandardError.new('Invalid coordinates.')
    end
  end

  private
  attr_reader :board, :target

  def valid_shot?
    board.space_names.include?(target)
  end

  def space
    @space ||= board.locate_space(target)
  end
end
