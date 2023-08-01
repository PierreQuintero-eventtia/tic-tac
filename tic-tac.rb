
class Game
  SYMBOLS=["X", "O"]
  ROW_WINNING_COMBINATIONS = [[0, 0, 1, 2], [1, 0, 1, 2], [2, 0, 1, 2]].freeze
  COL_WINNING_COMBINATIONS = [[0, 1, 2, 0], [0, 1, 2, 1], [0, 1, 2, 2]].freeze
  DIAG_WINNING_COMBINATIONS = [[0,0, 1,1, 2,2], [2,0, 1,1, 0, 2]].freeze

  def initialize
    @board = create_board
    @current_symbol= SYMBOLS.sample
    @turn = 0
    @message = ""
  end

  def play
      until @turn == 9
      show_board
      turn
        if game_over?
          show_board
          get_message
          puts "Game over - #{@message}"
          break
        end
      end
  end

  def game_over?
    return true if is_winner? || is_draw?
    false
  end

  def turn
    puts "Please enter two coordinates (0,1) for your move :"
    user_input = gets.strip
    row,col = user_input.split(',')
    if valid_move?(row.to_i,col.to_i)
      show_board
      move(row.to_i,col.to_i)
    else
      puts "Invalid move. Try again."
    end
 end

  def create_board
    {
      0=>{0=> nil, 1=> nil, 2=> nil },
      1=>{0=> nil, 1=> nil, 2=> nil },
      2=>{0=> nil, 1=> nil, 2=> nil }
    }
  end

  def is_winner?
    return true if ROW_WINNING_COMBINATIONS.any? do |row, a, b, c|
      [@board[row][a], @board[row][b], @board[row][c]].uniq.length == 1 && @board[row][a] != nil
    end

    return true if  COL_WINNING_COMBINATIONS.any? do |row1 ,row2, row3, a|
      [@board[row1][a], @board[row2][a], @board[row3][a]].uniq.length == 1 && @board[row1][a] != nil
    end

    return true if  DIAG_WINNING_COMBINATIONS.any? do |a,b,c,d,e,f|
      [@board[a][b], @board[c][d], @board[e][f]].uniq.length == 1 && @board[a][b] != nil
    end
    false
  end

  def get_message
    @message = if is_winner?
                  " Congrats -- You Win !!"
               elsif is_draw?
                  " It's a Draw"
               else
                " "
               end

  end

  def is_draw?
    @all_values.flatten.none?{|cell| cell == "-" }
  end

  def show_board
    @all_values = []
      3.times do |row|
        pp "   0 -- 1 -- 2" if row==0
        line = []
       3.times.each do |key_col, value_col|
        value = @board[row][key_col].nil? ? '-' : @board[row][key_col]
        line << value
       end
       @all_values << line
       puts "#{row}-#{line}"
      end
  end

  def current_symbol
    @current_symbol
  end

  def move(row, col)
    @board[row][col]= @current_symbol
    @turn += 1
    swap_symbol
  end

  def swap_symbol
    @current_symbol= @current_symbol == SYMBOLS[0] ? SYMBOLS[1] : SYMBOLS[0]
  end

  def valid_move?(row,col)
    return false if row > 2
    return false if col > 2
    return false unless @board[row][col].nil?
    true
  end
end



juego = Game.new
puts "+++++++  NEW GAME +++++++"
puts juego.play
puts "++++++  FINISHED GAME +++++++++"

