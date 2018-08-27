require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :player_1_board }
    it { should validate_presence_of :player_2_board }  
  end
end
