class View

 def print_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n===+===+===\n #{board[3]} | #{board[4]} | #{board[5]} \n===+===+===\n #{board[6]} | #{board[7]} | #{board[8]} \n"
 end

  def tie_message
    puts "It's a tie, game over!"
  end

  def win_message(name)
    puts "#{name} wins! Game over."
  end

  def ask_user_for(stuff)
    puts "#{stuff}?"
    print "> "
    return gets.chomp.to_i
  end


end
