class GameSerializer < ActiveModel::Serializer
  attributes :id, :current_turn, :player_1_board, :player_2_board, :history

  def player_1_board
    BoardSerializer.new(object.player_1_board).attributes
  end

  def player_2_board
    BoardSerializer.new(object.player_2_board).attributes
  end

  def history
    object.history
  end
end
