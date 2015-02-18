require_relative "./spec_helper"

describe Interface do

  let(:interface) {Interface.new}
  let(:players) {[Player.new, Player.new]}
  let(:board) {Board.new}

  describe "#get_names" do
    it "returns an array of names for all players" do
      allow(interface).to receive(:gets).and_return("Lara", "Jane")
      expect(interface).to receive(:puts).with("\n\nPlease enter the name of player 1:")
      expect(interface).to receive(:puts).with("\n\nPlease enter the name of player 2:")
      expect(interface.get_names(players)).to eql(["Lara", "Jane"])
    end

    it "should validate that a name is entered" do
      allow(interface).to receive(:gets).and_return("", "", "Lara", "Tom")
      expect(interface).to receive(:puts).with("\n\nPlease enter the name of player 1:")
      expect(interface).to receive(:puts).with("Invalid input.  Please type a name:").twice
      expect(interface).to receive(:puts).with("\n\nPlease enter the name of player 2:")
      expect(interface.get_names(players)).to eql(["Lara", "Tom"])
    end
  end

  describe "#input_valid?" do
    it "returns true for inputs from 1-9" do
      ("1".."9").all? {|num| expect(interface.input_valid?(num)).to be true}
    end

    it "returns false for inputs other than 1-9" do
      expect(interface.input_valid?("g")).to be false
      expect(interface.input_valid?("0")).to be false
      expect(interface.input_valid?("")).to be false
    end
  end

  describe "get_turn" do
    before(:all) do
      players[0].name = "Frank"
      players[0].preference = "0"

      it "returns an integer between 1 and 9, inclusive" do
        expect(interface).to receive(:puts).with("\nFrank, please take your turn:")
        allow(interface).to receive(:gets).and_return("1")
        expect(interface.get_turn(players[0], board)).to eql(1)
      end

      it "returns an error message if input other than 1-9 is entered" do
        expect(interface).to receive(:puts).with("\nFrank, please take your turn:")
        allow(interface).to receive(:gets).and_return("", "y", "0", "nnnn", "3")
        expect(interface).to receive(:puts).with("Invalid input.  Please use keys 1-9 to choose an empty position.\n\n").exactly(4).times
        expect(interface.get_turn(players[0], board)).to eql(3) 
      end

      it "returns an error message if the move has already been taken" do
        board.board[3..6] = ["X", "O", "X", "O"]
        expect(interface).to receive(:puts).with("\nFrank, please take your turn:")
        allow(interface).to receive(:gets).and_return("4", "5", "6", "7", "8")
        expect(interface).to receive(:puts).with("Invalid input.  Please use keys 1-9 to choose an empty position.\n\n").exactly(4).times
        expect(interface.get_turn(players[0], board.board)).to eql(8)
      end
    end
  end

  describe "#declare_win" do

    it "returns congratulations to the winner if the game is won" do
      board.board[0..2] = ["X", "X", "X"]
      players[0].name = "Caroline"
      players[0].preference = "X"
      #allow(board.board).to receive(:win?).and_return(true)
      expect(interface).to receive(:puts).with("\nGame over!")
      expect(interface).to receive(:puts).with("\nCongrats, Caroline!")
      interface.declare_win(players[0], board)
    end

    it "returns a tie message if no win condition is met" do
      players[0].name = "Katie"
      players[0].preference = "X"
      expect(interface).to receive(:puts).with("\nGame over!")
      expect(interface).to receive(:puts).with("\nTie!")
      interface.declare_win(players[0], board)
    end
  end
end