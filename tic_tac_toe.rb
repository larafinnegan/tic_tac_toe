class Player
attr_accessor :name, :preference

	def initialize(name, preference)
		@name = name
		@preference = preference
	end
end

class Board

	@@possible_inputs = [7,8,9,4,5,6,1,2,3]
    
    def initialize
        @area = Array.new(9)    
    end

	def display_game
		puts @area[0..2].join("  |  ")
		puts "-----------"
		puts @area[3..5].join("  |  ")
		puts "-----------"
		puts @area[6..8].join("  |  ")
	end

	def invalid_input(input)
		true if !@@possible_inputs.include?(input)
	end

	def already_taken(input)
		true if @area[@@possible_inputs.index(input)] != nil
	end

	def take_turn(turn, value)
		@area[@@possible_inputs.index(turn)] = value
	end
	
	def win?
		win = ["XXX","OOO"]
		if win.include?(@area[0..2].join("")) ||
			win.include?(@area[3..5].join("")) ||
			win.include?(@area[6..8].join("")) ||
			win.include?([@area[0], @area[3], @area[6]]) ||
			win.include?([@area[1], @area[4], @area[7]]) ||
			win.include?([@area[2], @area[5], @area[8]]) ||
			win.include?([@area[0], @area[4], @area[8]]) ||
			win.include?([@area[2], @area[4], @area[6]])
			return true
		end
	end

	def tie?
		@area.all? {|x| x != nil}
	end
end

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
		x_or_o = ["X","O"]
		x_or_o.shuffle
		
		@players = [Player.new(name1, x_or_o[0]), Player.new(name2, x_or_o[1])]
		@players.shuffle
        
		puts "\n\n#{@players[0].name} has been randomly assigned to #{@players[0].preference}."
		puts "Therefore, #{@players[1].name} has been assigned to #{@players[1].preference}."
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
		if @board.tie? || @board.win?
			true
		else
			false
		end
	end

	def play
		while game_over? == false
			new_turn
			@board.display_game
		end
		puts "Game over!"
		if @board.win?
			puts "Congrats, #{@current_player.name}!!" 
		else 
			puts "Tie!"
		end
	end
end

game = Game.new
game.play