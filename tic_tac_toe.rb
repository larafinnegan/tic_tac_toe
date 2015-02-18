require_relative './player'
require_relative './board'
require_relative './input'

class Game
  attr_reader :board, :interface, :players

  def initialize(board = Board.new, interface = Interface.new, players = [Player.new, Player.new])
    @board = board
    @interface = interface
    @players = players
  end

  def create_players
    names = interface.get_names(players)
    players.each_with_index {|player, i| player.name = names[i]}
  end

  def set_piece
    x_or_o = ["X","O"].shuffle
    players[0].preference = x_or_o[0]
    players[1].preference = x_or_o[1]
    interface.assign_piece(players)
  end

  def who_goes_first
    players.shuffle!
    interface.first_turn(players[1])
  end

  def make_turn
    turn = interface.get_turn(players[0], board)
    board.take_turn(turn, players[0].preference)
  end

  def intro
    interface.instructions
    create_players
    set_piece
    who_goes_first
  end

  def game_over?(input)
    board.tie? || board.win?(input)
  end

  def play
    intro
    until game_over?(players[0].preference)
      players.reverse!
      make_turn
      interface.display(board.board)
    end
    interface.declare_win(players[0], board)
  end
end

#game = Game.new
#game.play