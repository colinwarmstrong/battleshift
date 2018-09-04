FactoryBot.define do
  factory :game do
    player_1_board { Board.new(4) }
    player_2_board { Board.new(4) }
    winner { nil }
    player_1_turns { 0 }
    player_2_turns { 0 }
    current_turn { 0 }
    user_1_id { nil }
    user_2_id { nil }
  end
end
