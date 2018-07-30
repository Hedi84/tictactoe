class View

 def print_board(board)
  puts  puts " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
  puts "Enter [0-8]:"
 end

def tie_message
  puts "It's a tie, game over!"
end

def win_message(name)
  puts "#{name} wins! Game over."
end


end
