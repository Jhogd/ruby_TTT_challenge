require 'test/unit'
require_relative '../src/algorithm'
require_relative '../src/util'

class Test_algorithm_X < Test::Unit::TestCase
  def setup
    @game = Game_Logic.new(3)
    @ai = Min_Max_Alg.new(@game, "X")
    @board = @game.board

  end

  def game_state_one
    @game.make_move!("X", 0, 0)
    @game.make_move!("O", 0, 1)
    @game.make_move!("X", 1, 0)
    @game.make_move!("O", 0, 2)
  end

  def game_state_two
    @game.make_move!("X", 0, 0)
    @game.make_move!("O", 1, 1)
  end

  def game_state_three
    @game.make_move!("X", 1, 1)
    @game.make_move!("O", 0, 0)
    @game.make_move!("X", 0, 1)
    @game.make_move!("O", 2, 0)
  end

  def game_state_four
    @game.make_move!("X", 0, 0)
    @game.make_move!("O", 1, 1)
    @game.make_move!("X", 0, 1)
    @game.make_move!("O", 0, 2)
  end

  def game_state_five
    @game.make_move!("X", 0, 0)
    @game.make_move!("X", 1, 0)
    @game.make_move!("O", 0, 1)
    @game.make_move!("O", 2, 0)
  end

  def game_state_six
    @game.make_move!("X", 0, 0)
    @game.make_move!("O", 0, 2)
    @game.make_move!("X", 1, 0)
    @game.make_move!("O", 2, 0)
  end

  def game_state_seven
    @game.make_move!("X", 0, 0)
    @game.make_move!("O", 2, 2)
    @game.make_move!("X", 0, 2)
    @game.make_move!("O", 0, 1)
  end

  def test_best_move_state_zero
    assert_equal([0, 0], @ai.return_best_move(@board))
  end

  def test_best_move_state_one
    game_state_one
    assert_equal([2, 0], @ai.return_best_move(@board))
  end

  def test_best_move_state_two
    game_state_two
    assert_equal([0, 1], @ai.return_best_move(@board))
  end

  def test_best_move_state_three
    game_state_three
    assert_equal([2, 1], @ai.return_best_move(@board))
  end

  def test_best_move_state_four
    game_state_four
    assert_equal([2, 0], @ai.return_best_move(@board))
  end

  def test_best_move_state_five
    game_state_five
    assert_equal([1, 1], @ai.return_best_move(@board))
  end

  def test_best_move_state_six
    game_state_six
    assert_equal([1, 1], @ai.return_best_move(@board))
  end

  def test_best_game_state_seven
    game_state_seven
    assert_equal([2, 0], @ai.return_best_move(@board))
  end

end

class Test_algorithm_O < Test::Unit::TestCase
  ## AI can be X or O
  def setup
    @game = Game_Logic.new(3)
    @ai = Min_Max_Alg.new(@game, "O")
    @board = @game.board

  end

  def game_state_zero
    @game.make_move!("X", 0, 0)
  end

  def game_state_one
    @game.make_move!("X", 0, 0)
    @game.make_move!("O", 1, 1)
    @game.make_move!("X", 2, 2)
  end

  def game_state_two
    @game.make_move!("X", 2, 2)
    @game.make_move!("O", 1, 1)
    @game.make_move!("X", 0, 0)
  end

  def game_state_three
    @game.make_move!("X", 0, 2)
    @game.make_move!("O", 1, 1)
    @game.make_move!("X", 2, 2)
  end

  def test_best_move_zero
    game_state_zero
    assert_equal([1, 1], @ai.return_best_move(@board))
  end

  def test_best_move_one
    game_state_one
    assert_equal([0, 1], @ai.return_best_move(@board))
  end

  def test_best_move_two
    game_state_two
    assert_equal([0, 1], @ai.return_best_move(@board))
    @game.make_move!("O", 0, 1)
    @game.make_move!("X", 0, 2)
    assert_equal([2, 1], @ai.return_best_move(@board))
  end

  def test_best_move_three
    game_state_three
    assert_equal([1, 2], @ai.return_best_move(@board))
  end

  end