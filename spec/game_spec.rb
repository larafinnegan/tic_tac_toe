require_relative "./spec_helper"

describe Game do
  
  let(:game) {Game.new}

  describe "#create_players" do
    it "asks player 1 for input" do
      expect(game.create_players).to receive(:puts).with("\n\nPlease enter the name of player 1:")
    end
  end

end