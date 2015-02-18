require_relative "./spec_helper"

describe Game do

  let(:game) {Game.new}
  let(:board) {Board.new}
  let(:players) {[Player.new, Player.new]}
  let(:interface) {Interface.new}

  describe "#game_over?" do
    it "returns true when a tie or win condition is met" do 
      allow(game.board).to receive(:win?).and_return(true)
      allow(game.board).to receive(:tie?).and_return(false)
      expect(game.game_over?("pref")).to be true
      allow(game.board).to receive(:win?).and_return(false)
      allow(game.board).to receive(:tie?).and_return(true)
      expect(game.game_over?("pref")).to be true
    end

    it "returns false when no tie or win condition is met" do 
      allow(game.board).to receive(:win?).and_return(false)
      allow(game.board).to receive(:tie?).and_return(false)
      expect(game.game_over?("pref")).to be false
    end
  end

  describe "#create_players" do
    it "creates players and gives them names" do
      allow(game.interface).to receive(:get_names).and_return(["Lara", "Frank"])
      players = game.create_players
      expect(players[0].name).to eql("Lara")
      expect(players[1].name).to eql("Frank")
    end
  end

  describe "#set_piece" do
    it "assigns X to one player and O to another" do
      expect(game.players[0].preference).to eql("O") if game.players[1].preference == "X"
      expect(game.players[1].preference).to eql("O") if game.players[0].preference == "X"
      allow(game.interface).to receive(:assign_piece)
      game.set_piece
    end
  end

  describe "#who_goes_first" do
    it "chooses a random player to go first" do
      first = []
      game.players[0].name = "Joe"
      game.players[1].name = "Ray"
      10.times do
        allow(game.interface).to receive(:first_turn)
        game.who_goes_first
        first << game.players[1].name
      end
      expect(first.all? {|x| x == first[0]}).to be false
    end
  end
end
