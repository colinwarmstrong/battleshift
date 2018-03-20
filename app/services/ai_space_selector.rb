class AiSpaceSelector
  def initialize(target_board)
    @target_board = target_board
  end

  def fire!
    select_space.attack!
  end

  private
    attr_reader :target_board

    def select_space
      non_targeted_spaces.sample.values.first
    end

    def non_targeted_spaces
      target_board.board.flatten.select do |raw_space|
        raw_space.values.first.not_attacked?
      end
    end
end
