class Shooter
  def initialize(board:, target:)
    @board     = board
    @target   = target
  end

  def fire!
    space.attack!
  end

  def self.fire!(board:, target:)
    new(board: board, target: target).fire!
  end

  private
    attr_reader :board, :target

    def space
      @space ||= board.locate_space(target)
    end
end

