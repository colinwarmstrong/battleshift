FactoryBot.define do
  factory :game do
    player_1_board { "You should add a board object" }
    player_2_board { "You should add a board object" }
    winner { nil }
    player_1_turns { 0 }
    player_2_turns { 0 }
    current_turn { 0 }
    user_1_id { user.id }
    user_2_id { user.id }
  end
end
