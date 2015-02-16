require_relative './player'
require_relative './board'
require_relative './input'

class Game
  attr_reader :board, :interface

  def initialize(board = Board.new, interface = Interface.new)
    @board = board
    @interface = interface
  end

  def create_players
    @players = [Player.new, Player.new]
    interface.set_names(@players)
    interface.set_piece(@players)
  end

  def who_goes_first
    @players.shuffle!
    interface.first_turn(@players[1])
  end

  def make_turn
    turn = interface.get_turn(@players[0], board)
    board.take_turn(turn, @players[0].preference)
  end

  def intro
    interface.instructions
    create_players
    who_goes_first
  end

  def play
    intro
    until board.game_over?(@players[0].preference)
      @players.reverse!
      make_turn
      interface.display(board.board)
    end
    interface.declare_win(@players[0], board)
  end
end

game = Game.new
game.play