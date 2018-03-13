FactoryBot.define do
  factory :game do
    player_1_board "MyText"
    player_2_board "MyText"
    winner 1
    player_1_turns 1
    player_2_turns 1
    current_turn "MyString"
  end
end
