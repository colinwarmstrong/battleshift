class TurnProcessor
  def initialize(game, target)
    @game     = game
    @target   = target
    @messages = []
  end

  def run!
    begin
      if @game.current_turn == 'Player 1'
        attack(@game.player_2_board, @game.user_1)
        game.update(current_turn: 1)
      else
        attack(@game.player_1_board, @game.user_2)
        game.update(current_turn: 0)
      end
    rescue StandardError => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target, :messages

  def attack(board, user)
    result = Shooter.new(board: board, target: target).fire!
    messages << "Your shot resulted in a #{result[:hit_or_miss]}."
    messages << 'Battleship sunk.' if result[:sunk] == true
    messages << 'Game over.' if game_won?(board, user)
  end

  def game_won?(board, user)
    if board.ship_count == 0
      game.update(winner: user.email)
      return true
    end
  end
end
