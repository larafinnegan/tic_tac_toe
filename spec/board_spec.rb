require_relative "./spec_helper"

describe Board do 

  let(:board) {Board.new}

  describe "#initialize" do
    it "should be an array consisting of 9 elements, all dashes" do
      expect(board.board).to eql(Array.new(9, "-"))
    end
  end

  describe "#take_turn" do
    it "updates the board with an X or O" do
      board.take_turn(3, "X")
      expect(board.board).to eql(["-", "-", "X", "-", "-", "-", "-", "-", "-"])
      board.take_turn(6, "O")
      expect(board.board).to eql(["-", "-", "X", "-", "-", "O", "-", "-", "-"])
    end
  end

  describe "#move_valid?" do
    it "should return true if the desired move currently contains a dash" do
      (1..9).each {|x| expect(board.move_valid?(x)).to be true}
    end

    it "should return false if the desired move currently contains a dash" do
      board.board.map! {|elem| elem == "X"}
      (1..9).each {|x| expect(board.move_valid?(x)).to be false}
      board.board.map! {|elem| elem == "O"}
      (1..9).each {|x| expect(board.move_valid?(x)).to be false}
    end
  end

  describe "#tie?" do
    it "should return false if there are still moves available (designated by dash)" do
      expect(board.tie?).to be false
      (1..8).each {|index| board.board[index] == "X"}
      expect(board.tie?).to be false
    end

    it "should return true if there are no moves available (no more dashes)" do
      board.board.map! {|elem| elem == "O"}
      expect(board.tie?).to be true
    end
  end

  describe "#win?" do
    it "should return false if no win condition is met" do
      expect(board.win?("X")).to be false
    end

    it "should return true if a horizontal win condition is met" do
      board.board = ["X", "X", "X", "-", "-", "-", "-", "-", "-"]
      expect(board.win?("X")).to be true
      board.board = ["-", "-", "-", "-", "-", "-", "X", "X", "X"]
      expect(board.win?("X")).to be true
      board.board = ["-", "-", "-", "O", "O", "O", "-", "X", "X"]
      expect(board.win?("X")).to be false
      expect(board.win?("O")).to be true
    end

    it "should return true if a vertical win condition is met" do
      board.board = ["X", "O", "O", "X", "-", "-", "X", "-", "O"]
      expect(board.win?("X")).to be true
      board.board = ["-", "O", "-", "-", "O", "-", "-", "O", "-"]
      expect(board.win?("O")).to be true
      board.board = ["-", "O", "X", "-", "-", "X", "O", "-", "X"]
      expect(board.win?("O")).to be false
      expect(board.win?("X")).to be true
    end

    it "should return true if a diagonal win condition is met" do
      board.board = ["X", "-", "-", "-", "X", "-", "-", "-", "X"]
      expect(board.win?("X")).to be true
      board.board = ["X", "X", "O", "X", "O", "X", "O", "-", "-"]
      expect(board.win?("O")).to be true
      expect(board.win?("X")).to be false
    end
  end
end