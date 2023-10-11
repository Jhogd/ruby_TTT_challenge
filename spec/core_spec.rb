require 'test/unit'
require_relative '../src/core'
require_relative '../src/util'
require_relative '../src/algorithm'


class Test_Tic_Tac_toe < Test::Unit::TestCase

  def setup
    @ttt = Tic_Tac_Toe.new("X")
    @game = Game_Logic.new(3)
    @ai = Min_Max_Alg.new(@game, "X")
    def @ttt.puts(text)
      @captured_output ||= []
      @captured_output << text
    end
    def Tic_Tac_Toe.puts(text)
      @class_captured_output ||= []
      @class_captured_output << text
    end
  end

  def test_init
    assert_instance_of(Game_Logic, @ttt.game, "instance of logic class")
    assert_instance_of(Min_Max_Alg, @ttt.ai, "instance of minmax class")
  end

  def test_ending_message
    assert_equal("The Ai has won, sorry!", @ttt.ending_message("O"))
    assert_equal("You have won!!", @ttt.ending_message("X"))
    assert_equal("The game is a draw", @ttt.ending_message(" "))
  end

  def test_player_message
    assert_equal("The Ai is choosing a move", @ttt.player_turn_message("O"))
    assert_equal("Please enter a valid move i.e 0 0, 1 1, etc..", @ttt.player_turn_message("X"))
  end

  def test_select_player
    def Tic_Tac_Toe.gets
      "1\n"
    end
    Tic_Tac_Toe.select_player
    assert_equal("Please enter a 1 or 2 to choose your player\n 1) X\n 2) O", Tic_Tac_Toe.instance_variable_get(:@class_captured_output)[0])
    assert_equal("X", Tic_Tac_Toe.select_player)
  end

  def test_play_game_display
    def @ttt.gets
      @counter ||= -1
      @counter += 1
      ["0 1", "0 2", "1 0", "1 1", "1 2", "2 0", "2 1", "2 2"][@counter]
    end
    #displays board and messages as game updates calls all functions ends with a winner
    new_game = @ttt.game
    board = new_game.board
    assert_equal([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]], board)
    @ttt.play_game
    assert_equal([["O", "X", "X"], ["O", "X", " "], ["O", " ", " "]], board)
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("The Ai will act as player O good luck!"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("\n" + " | | \n" + "-----\n" + " | | \n" + "-----\n" + " | | \n" + "\n"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("Please enter a valid move i.e 0 0, 1 1, etc.."))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("\n" + " |X| \n" + "-----\n" + " | | \n" + "-----\n" + " | | \n" + "\n"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("The Ai is choosing a move"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("\n" + "O|X|X\n" + "-----\n" + " | | \n" + "-----\n" + " | | \n" + "\n"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("\n" + "O|X|X\n" + "-----\n" + "O| | \n" + "-----\n" + " | | \n" + "\n"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("\n" + "O|X|X\n" + "-----\n" + "O|X| \n" + "-----\n" + " | | \n" + "\n"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("\n" + "O|X|X\n" + "-----\n" + "O|X| \n" + "-----\n" + "O| | \n" + "\n"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("Invalid Move! please try again"))
    assert_true(@ttt.instance_variable_get(:@captured_output).include?("The Ai has won, sorry!"))
  end

  end