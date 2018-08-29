class GameSerializer < ActiveModel::Serializer
  attributes :id, :message, :current_turn, :player_1_board, :player_2_board

  def player_1_board
    BoardSerializer.new(object.player_1_board).attributes
  end

  def player_2_board
    BoardSerializer.new(object.player_2_board).attributes
  end

  def message
    "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
    binding.pry
    
    @instance_options[:message]
  end

end
