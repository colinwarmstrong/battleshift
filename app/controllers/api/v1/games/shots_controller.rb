module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = Game.find(params[:game_id])

          player = Player.new(game.player_1_board)
          computer = Player.new(game.player_2_board)

          # player shoots
          Shooter.fire!(board: computer.board, target: params[:shot][:target])
          game.player_1_turns += 1

          # computer shoots
          AiSpaceSelector.new(player.board).fire!
          game.player_2_turns += 1

          # should set a message with the status of the attack here

          # save the state from the above moves
          game.save!
          render json: game
        end
      end
    end
  end
end
