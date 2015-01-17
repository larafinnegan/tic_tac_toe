require '.\player'
require '.\board'

class Game
    def initialize
		@board = Board.new
		puts "\n\nINSTRUCTIONS"
		puts "Use the 1-9 keys to make your turn.\n\n"
		puts "        1|2|3"
		puts "        4|5|6"
		puts "        7|8|9"
		puts "\n\nPlease enter the name of player 1:"
		name1 = gets.chomp
		puts "\n\nPlease enter the name of player 2:"
		name2 = gets.chomp
		x_or_o = ["X","O"].shuffle
		@players = [Player.new(name1, x_or_o[0]), Player.new(name2, x_or_o[1])]
		@players.shuffle!
        
		puts "\n\n#{@players[0].name} has been randomly assigned to #{@players[0].preference}."
		puts "Therefore, #{@players[1].name} has been assigned to #{@players[1].preference}."
		puts "\nThe computer has randomly decided who will go first.\n\n"
	end
	
	def board
		@board
	end

	def turn
		puts "\n#{@players[0].name}, please take your turn:"
		turn = gets.chomp
		until input_valid?(turn) && board.move_valid?(turn.to_i)
			puts "Invalid input.  Please use keys 1-9 to choose an empty position."
			board.display_game
			turn = gets.chomp
		end
		board.take_turn(turn.to_i, @players[0].preference)
	end
	
	def input_valid?(turn)
		("1".."9").to_a.include?(turn)
	end

	def game_over?
		board.tie? || board.win?(@players[0].preference)
	end

	def play
		until game_over?
			@players.reverse!
			board.display_game
			turn
		end
		board.display_game
		puts "\nGame over!"
		if board.win?(@players[0].preference)
			puts "\nCongrats, #{@players[0].name}!!"
		else
			puts "\nTie!"
		end
	end
end

game = Game.new
game.play