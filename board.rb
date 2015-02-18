class Board
  attr_accessor :board

  def initialize(board = Array.new(9, "-"))
    @board = board
  end

  def move_valid?(input)
    board[input - 1] == "-"
  end

  def take_turn(turn, value)
    board[turn - 1] = value
  end

  def win_positions
    [[0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]]
  end

  def win?(input)
    win_positions.any? {|pos| [board[pos[0]], board[pos[1]], board[pos[2]]].join == (input * 3)}
  end

  def tie?
    board.none? {|x| x == "-"}
  end	
end
