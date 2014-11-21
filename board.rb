class Board

	@@possible_inputs = [7,8,9,4,5,6,1,2,3]
    
    def initialize
        @area = Array.new(9)    
    end

	def display_game
		puts @area[0..2].join(" | ")
		puts "-----------"
		puts @area[3..5].join(" | ")
		puts "-----------"
		puts @area[6..8].join(" | ")
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
		win = [["X","X","X"],["O","O","O"]]
		if win.include?(@area[0..2]) ||
			win.include?(@area[3..5]) ||
			win.include?(@area[6..8]) ||
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