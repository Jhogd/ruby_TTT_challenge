class Game_Logic
  def initialize(size)
    @board = Array.new(size) { Array.new(size, ' ') }
    @current_player = "X"
  end

  def board
    @board
  end

  def current_player
    @current_player
  end

  def switch_player(player)
    (player == "X") ? "O" : "X"
  end

  def display_board(board)
    printed_board = "\n"
    board.each_with_index do |row, idx|
      printed_board += "#{row.join('|')}\n"
      printed_board += "-----\n" unless idx == 2
    end
    printed_board += "\n"
  end

  def make_move!(player, position1, position2)
    board[position1][position2] = player
  end

  def board_full?(board)
    board.all? { |row| row.none? { |cell| cell == " " } }
  end

  def board_empty?(board)
    board.all? { |row| row.all? { |cell| cell == " " } }
  end

  def board_size
    board[0].length - 1
  end

  def section_win?(section, player)
    section.all? { |cell| cell == player }
  end

  def check_win_hor_vert(board, player)
    outcome = []
    board.each do |section|
      if section_win?(section, player)
        outcome.append(true)
      else
        outcome.append(false)
      end
    end
    outcome.include?(true)
  end

  def check_win_diags(board, player)
    diag = (0..board_size).collect { |i| board[i][i] }
    inverse_diag = (0..board_size).collect { |i| board[i][-i - 1] }
    section_win?(diag, player) or (section_win?(inverse_diag, player))
  end

  def check_win(board, player)
    check_win_hor_vert(board, player) or
      check_win_hor_vert(board.transpose, player) or
      check_win_diags(board, player)
  end

  def terminal(board)
    winner = { check_win(board, "X") => "X",
               check_win(board, "O") => "O",
               board_full?(board) => " " }
    winner[true]
  end

  def parse_user_input(move_string)
    move_string.chomp.split.map(&:to_i)
  end

  def within_board_range(move)
    (0..board_size).include?(move)
  end

  def valid_move?(move, board)
    move.length == 2 &&
      within_board_range(move[0]) &&
      within_board_range(move[1]) &&
      board[move[0]][move[1]] == " "
  end

end
