require_relative './board'

class Interface
  attr_reader :interface

  def initialize
    @interface = interface
  end

  def instructions
    puts "\n\nINSTRUCTIONS"
    puts "Use the 1-9 keys to make your turn.\n\n"
    puts "1|2|3\n4|5|6\n7|8|9"
  end

  def get_names(players)
    names = []
    players.each_with_index do |player, i|
      puts "\n\nPlease enter the name of player #{i+1}:"
      name = gets.chomp.downcase.capitalize
      while name == ""
        puts "Invalid input.  Please type a name:"
        name = gets.chomp.downcase.capitalize
      end
      names << name
    end
    names
  end

  def display(board)
    puts board[0..2].join("|")
    puts board[3..5].join("|")
    puts board[6..8].join("|")
  end

  def assign_piece(players)
    puts "\n\n#{players[0].name} has been randomly assigned to #{players[0].preference}."
    puts "Therefore, #{players[1].name} has been assigned to #{players[1].preference}."
  end

  def first_turn(player)
    puts "\nThe computer has randomly decided that #{player.name} will go first.\n\n"
  end

  def get_turn(player, board)
    puts "\n#{player.name}, please take your turn:"
    turn = gets.chomp
    until input_valid?(turn) && board.move_valid?(turn.to_i)
      puts "Invalid input.  Please use keys 1-9 to choose an empty position.\n\n"
      turn = gets.chomp
    end
    turn.to_i
  end

  def input_valid?(turn)
    ("1".."9").to_a.include?(turn)
  end

  def declare_win(player, board)
    puts "\nGame over!"
    board.win?(player.preference) ? (puts "\nCongrats, #{player.name}!") : (puts "\nTie!")
  end
end