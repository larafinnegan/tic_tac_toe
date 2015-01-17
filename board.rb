class Board
attr_accessor :board

    def initialize(board = Array.new(9, "_"))
        @board = board
    end

	def display_game
		puts board[0..2].join("|")
		puts board[3..5].join("|")
		puts board[6..8].join("|")
	end

	def move_valid?(input)
		board[input - 1] == "_"
	end

	def take_turn(turn, value)
		board[turn - 1] = value
	end
	
	def win?(input)
		board[0..2].join == (input * 3) ||
		board[3..5].join == (input * 3) ||
		board[6..8].join == (input * 3) ||
		[board[0], board[3], board[6]].join == (input * 3) ||
		[board[1], board[4], board[7]].join == (input * 3) ||
		[board[2], board[5], board[8]].join == (input * 3) ||
		[board[0], board[4], board[8]].join == (input * 3) ||
		[board[2], board[4], board[6]].join == (input * 3)
	end

	def tie?
		board.none? {|x| x == "_"}
	end	
end