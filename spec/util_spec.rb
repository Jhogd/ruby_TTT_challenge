require 'test/unit'
require_relative '../src/util'


class Test_Game_logic < Test::Unit::TestCase
  def setup
    @game = Game_Logic.new(3)
  end

  def fill_board(board, player)
    board.each_with_index do |row, row_idx|
      row.each_with_index do |_, col_idx|
        board[row_idx][col_idx] = player
        player = @game.switch_player(player)
      end
    end
  end

  def test_board_init
    test_board = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    assert_equal(test_board, @game.board, "board should be 3 by 3 and empty")
  end

  def test_initial_player
    assert_equal("X", @game.current_player, "player starts as X")
  end

  def test_switch_player
    player = @game.switch_player("X")
    assert_equal("O", player, "switches to O")
    player = @game.switch_player("O")
    assert_equal("X", player, "switches back to X")
  end

  def test_display_board
    board_display = "\n" + " | | \n" + "-----\n" + " | | \n" + "-----\n" + " | | \n" + "\n"
    assert_equal(board_display, @game.display_board(@game.board), "displays board")
  end
  def test_make_move
    pos1 = 0
    pos2 = 1
    pos3 = 2
    pos4 = 1
    @game.make_move("X", pos1, pos2)
    @game.make_move("O", pos3, pos4)
    @game.make_move("X", pos1, pos3)
    @game.make_move("O", pos3, pos1)
    assert_equal("X", @game.board[pos1][pos2], "makes move")
    assert_equal("O", @game.board[pos3][pos4], "makes move again")
    assert_equal("X", @game.board[pos1][pos3], "makes move again")
    assert_equal("O", @game.board[pos3][pos1], "makes move again")
  end

  def test_board_full
    assert_false(@game.board_full?(@game.board), "board is empty")
    @game.make_move("X", 0, 1)
    @game.make_move("O", 1, 1)
    assert_false(@game.board_full?(@game.board), "board has two filled spots but not full")
    fill_board(@game.board, "X")
    assert_true(@game.board_full?(@game.board), "board is full")
  end

  def test_board_empty
    @game.make_move("X", 0, 1)
    assert_false(@game.board_empty?(@game.board), "not empty")
    @game.make_move("O", 1, 1)
    assert_false(@game.board_empty?(@game.board), "multiple moves")
    @game.make_move(" ", 0, 1)
    @game.make_move(" ", 1, 1)
    assert_true(@game.board_empty?(@game.board), "empty")
  end

  def test_win_hor_top_row
    player = "X"
    assert_false(@game.check_win_hor_vert(@game.board, player), "no moves")
    @game.make_move(player, 0, 0)
    @game.make_move(player, 0, 1)
    assert_false(@game.check_win_hor_vert(@game.board, player), "two moves")
    @game.make_move(player, 0, 2)
    assert_true(@game.check_win_hor_vert(@game.board, player), "top row full of X")

  end

  def test_win_hor_middle_row
    player = "O"
    assert_false(@game.check_win_hor_vert(@game.board, player), "no moves")
    @game.make_move(player, 1, 0)
    @game.make_move(player, 1, 1)
    assert_false(@game.check_win_hor_vert(@game.board, player), "two moves")
    @game.make_move("X", 1, 2)
    assert_false(@game.check_win_hor_vert(@game.board, player), "X takes the spot instead")
    @game.make_move(player, 1, 2)
    assert_true(@game.check_win_hor_vert(@game.board, player), "second row full of O")
    end
  def test_win_vert_first_col
    player = "X"
    assert_false(@game.check_win_hor_vert(@game.board.transpose, player), "no moves")
    @game.make_move(player, 0, 0)
    @game.make_move(player, 1, 0)
    assert_false(@game.check_win_hor_vert(@game.board.transpose, player), "two moves")
    @game.make_move("O", 2, 0)
    assert_false(@game.check_win_hor_vert(@game.board.transpose, player), "O takes the spot instead")
    @game.make_move(player, 2, 0)
    assert_true(@game.check_win_hor_vert(@game.board.transpose, player), "first col full of X")
  end

  def test_win_diag
    player = "O"
    assert_false(@game.check_win_diags(@game.board, player), "no moves")
    @game.make_move(player, 0, 0)
    @game.make_move(player, 1, 1)
    assert_false(@game.check_win_diags(@game.board, player), "2/3rd of diagonal")
    @game.make_move("X", 2, 2)
    assert_false(@game.check_win_diags(@game.board, player), "X takes the spot instead")
    @game.make_move(player, 2, 2)
    assert_true(@game.check_win_diags(@game.board, player), "diag is full of O")
  end

  def test_win_inverse_diag
    player = "X"
    assert_false(@game.check_win_diags(@game.board, player), "no moves")
    @game.make_move(player, 0, 2)
    @game.make_move(player, 1, 1)
    assert_false(@game.check_win_diags(@game.board, player), "2/3rd of diagonal")
    @game.make_move("O", 2, 0)
    assert_false(@game.check_win_diags(@game.board, player), "O takes the spot instead")
    @game.make_move(player, 2, 0)
    assert_true(@game.check_win_diags(@game.board, player), "diag is full of X")
  end

  def test_check_win
    player = "O"
    assert_false(@game.check_win(@game.board, player), "no moves")
    @game.make_move(player, 0, 0)
    @game.make_move(player, 1, 1)
    assert_false(@game.check_win(@game.board, player), "2 moves no win")
    @game.make_move(player, 0, 2)
    assert_false(@game.check_win(@game.board, player), "3 moves no win")
    @game.make_move(player, 2, 0)
    assert_true(@game.check_win(@game.board, player), "reverse diag win")
    @game.make_move("X", 2, 0)
    @game.make_move(player, 0, 1)
    @game.make_move(player, 0, 2)
    assert_true(@game.check_win(@game.board, player), "horizontal win")
    @game.make_move("X", 0, 2)
    @game.make_move(player, 2, 1)
    assert_true(@game.check_win(@game.board, player), "vertical win")
  end

  def test_user_move
    assert_equal([1 ,2], @game.parse_user_input("1 2"), "1 2")
    assert_equal([2 ,2], @game.parse_user_input("2 2"), "2 2")
    assert_equal([0 ,2], @game.parse_user_input("0 2"), "0 2")
    assert_equal([0 ,2], @game.parse_user_input(" 0     2 "), "removes extra space 0 2")
    assert_equal([1 ,1], @game.parse_user_input("1 1"), "1 1")
    assert_equal([1 ,1], @game.parse_user_input(" 1  1  "), "1 1 removes extra space")
  end

  def test_valid_move
    assert_false(@game.valid_move?([3, 3], @game.board), "not valid")
    assert_false(@game.valid_move?([3], @game.board), "not enough input")
    @game.make_move("X", 1 , 1)
    assert_false(@game.valid_move?([1, 1], @game.board), "already taken")
  end

  def test_terminal
    player = "X"
    assert_equal(nil , @game.terminal(@game.board))
    @game.make_move(player, 0, 2)
    @game.make_move(player, 1, 1)
    @game.make_move(player, 2, 0)
    assert_equal("X", @game.terminal(@game.board))
  end

end
