require_relative "./spec_helper"

describe Game do
  
  let(:game) {Game.new}

  describe "#create_players" do
    it "creates 2 players" do
      game.should_receive(:puts) {"\n\nPlease enter the name of player 1:"}
      game.stub(:gets) {"Lara\n"}
      game.should_receive(:puts) {"\n\nPlease enter the name of player 2:"}
      game.stub(:gets) {"Jane\n"}

    end
  end


  describe "#input_valid?" do
    it "returns true for inputs from 1-9" do
      ("1".."9").all? {|num| expect(game.input_valid?(num)).to be true}
    end

    it "returns false for inputs other than 1-9" do
      expect(game.input_valid?("g")).to be false
      expect(game.input_valid?("0")).to be false
      expect(game.input_valid?("")).to be false
    end
  end

  describe "#who_goes_first" do
    it "randomly assigns a player to go first" do
      output = []
      @players.stub! = [Player.new("name1", "X"), Player.new("name2", "O")]
      10.times {output << game.who_goes_first}
      expect(output.all? {|x| x == output[0]}).to be false
    end
  end
end