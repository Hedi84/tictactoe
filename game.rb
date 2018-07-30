require_relative 'view'

class Game

  def initialize
    @view = View.new
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @hum = "O"
    @com = "X"
  end

  def start_game
    # start by printing the board
    @view.print_board(@board)
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      @view.print_board(@board)
    end
      if tie(@board)
        @view.tie_message
      else
        player = []
        computer = []
        @board.each do |b|
          if b == @com
            computer << b
          elsif b == @hum
            player << b
          end
        end
            player.count > computer.count ? @view.win_message("user") : @view.win_message("the computer")
      end
  end

  def get_human_spot
    spot = nil
    until spot
      spot = @view.ask_user_for("Which number will you mark")
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @hum
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end


def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      elsif
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          if as.to_i != 1|| 3 || 5 || 7
            # I only want it to pick from strategic moves
            good_moves = []
            good_moves << as.to_i
            n = rand(0..good_moves.count)
            best_move = n.to_i
            board[n.to_i] = as
            return best_move
          else
            board[as.to_i] = as
          end
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move

      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      # does the array contain even numbers or 0?
       if available_spaces.any? {|a| a.to_i % 2 == 0 || a.to_i == 0}
          # I only want it to pick from strategic moves, so the corners.
          even_numbers = []
          available_spaces.each { |x| even_numbers << x if x.to_i.even? }
          even_numbers << 0 if available_spaces.include? "0"
          b = even_numbers.sample.to_i
          best_pick = b.to_i
          return best_pick
        else
          n = rand(0..available_spaces.count)
          return available_spaces[n].to_i
        end
    end
  end

  def game_is_over(b)

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

end

game = Game.new
game.start_game
