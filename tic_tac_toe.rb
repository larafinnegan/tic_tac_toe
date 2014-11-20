

    puts "Instructions"
    puts "Please enter the name of player 1:"
    name1 = gets.chomp

    puts "Please enter the name of player 2:"
    name2 = gets.chomp

if rand(2) == 0
    preference1 = " O "
    preference2 = " X "
    order1 = 1
    order2 = 2
else
    preference2 = " O "
    preference1 = " X "
    order1 = 2
    order2 = 1
end

puts "To be fair, the computer has randomly decided which player 
will play X and which will play O."

possible_inputs = [7,8,9,4,5,6,1,2,3]
board = ["   ","   ","   ","   ","   ","   ","   ","   ","   "]

def display_game(board)
puts board[0..2].join("|")
puts "-----------"
puts board[3..5].join("|")
puts "-----------"
puts board[6..8].join("|")
end


display_game(board)

class Player
attr_accessor :name, :preference, :order

def initialize(name, preference, order)
    @name = name
    @preference = preference
    @order = order
	end
end

player1 = Player.new(name1, preference1, order1)
player2 = Player.new(name2, preference2, order2)

puts player1.name + ":" + player1.preference
puts player2.name + ":" + player2.preference

puts "To be fair, the computer has randomly decided which player 
will go first."

if order2 < order1
current_player = player1
else current_player = player2
end

puts "#{current_player.name}, please take your turn:"
turn = gets.chomp
turn = turn.to_i
while possible_inputs.include?(turn) == false
puts "Invalid input. Please use keys 1 through 9"
turn = gets.chomp
turn = turn.to_i
    while board[turn-1] != "   "
    puts "Invalid choice.  That turn has been taken."
    turn = gets.chomp
    turn = turn.to_i
    end
end
board[possible_inputs.index(turn)] = current_player.preference
display_game(board)

def win?(board, pref)
if board[0]+board[1]+board[2] == pref * 3 ||
    board[3]+board[4]+board[5] == pref * 3 ||
    board[6]+board[7]+board[8] == pref * 3 ||
    board[0]+board[3]+board[6] == pref * 3 ||
    board[1]+board[4]+board[7] == pref * 3 ||
    board[2]+board[5]+board[8] == pref * 3 ||
    board[0]+board[4]+board[8] == pref * 3 ||
    board[2]+board[4]+board[6] == pref * 3
    return true
    end
end

def tie?(board)
board.all? {|x| x != "   "}
end

def game_over?
true if tie? || win?
end