require '.\player'
require '.\board'

class Game
    def initialize
		@board = Board.new
		
		puts "\n\nINSTRUCTIONS"
		puts "Use the 1-9 keys to make your turn.\n\n"
		puts "         7 | 8 | 9 "
		puts "        -----------"
		puts "         4 | 5 | 6 "
		puts "        -----------"
		puts "         1 | 2 | 3 "
		puts "\n\nPlease enter the name of player 1:"
		name1 = gets.chomp
		puts "\n\nPlease enter the name of player 2:"
		name2 = gets.chomp
		x_or_o = [" X "," O "]
		x_or_o.shuffle!
		
		@players = [Player.new(name1, x_or_o[0]), Player.new(name2, x_or_o[1])]
		@players.shuffle!
        
		puts "\n\n#{@players[0].name} has been randomly assigned to#{@players[0].preference}."
		puts "Therefore, #{@players[1].name} has been assigned to#{@players[1].preference}."
		puts "The computer has randomly decided who will go first.\n\n"
	end

	def switch_players
    	@players[1], @players[0] = @players[0], @players[1]
		@current_player = @players[0]
	end


	def new_turn
		switch_players
		puts "\n#{@current_player.name}, please take your turn:"
		turn = gets.chomp.to_i
		while @board.invalid_input(turn) || @board.already_taken(turn)
			puts "Invalid input.  Please use keys 1-9 to choose an empty position."
			@board.display_game
			turn = gets.chomp.to_i
		end
		@board.take_turn(turn, @current_player.preference)
	end

	def game_over?
		(@board.tie? || @board.win?) ? true : false
	end

	def play
		while !game_over?
			@board.display_game
			new_turn
		end
		@board.display_game
		puts "\nGame over!"
		if @board.win?
			puts "\nCongrats, #{@current_player.name}!!" 
		else 
			puts "\nTie!"
		end
	end
end

game = Game.new
game.play