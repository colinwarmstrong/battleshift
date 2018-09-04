require 'rails_helper'

describe Game, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :player_1_board }
    it { should validate_presence_of :player_2_board }
    it { should validate_presence_of :user_1_id }
    it { should validate_presence_of :user_2_id }
    it { should belong_to :user_1 }
    it { should belong_to :user_2 }
    it { should define_enum_for :current_turn }
  end
end
