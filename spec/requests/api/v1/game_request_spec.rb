require 'rails_helper'

describe 'Games API' do
  it "sends a success status in json" do
    post '/api/v1/games'

    expect(response).to be_successful
  end

  it "can build a board" do
    
  end
end