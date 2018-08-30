class TurnProcessor
  def initialize(game, target)
    @game     = game
    @target   = target
    @messages = []
  end

  def run!
    begin
      if @game.current_turn == 'Player 1'
        attack_opponent
      else
        attack_player
      end
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent
    result = Shooter.fire!(board: opponent.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_1_turns += 1
  end

  def attack_player
    result = Shooter.fire!(board: player.board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_2_turns += 1
  end

  def player
    Player.new(game.player_1_board)
  end

  def opponent
    Player.new(game.player_2_board)
  end
end
