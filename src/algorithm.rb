require_relative '../src/util'

class Min_Max_Alg

  def initialize(game, ai_player)
    @player = ai_player
    @game = game
  end

  def ai_player
    @player
  end

  def human_player
    @game.switch_player(ai_player)
  end

  def game_score(board)
    scores = { ai_player => 10, human_player => -10, " " => 0 }
    winner =  @game.terminal(board)
    scores[winner]
  end

  def min_or_max(score_array, min)
    min_max_selector = {true => score_array.min, false => score_array.max}
    min_max_selector[min]
  end

  def call_maxing_or_not_max(new_board, depth, min)
    if min
      maxing(new_board, depth + 1)
    else
      not_maxing(new_board, depth + 1)
    end
  end

  def get_score(board, best_score , depth, player, min, i, j)
    if board[i][j] == " "
      board[i][j] = player
      new_board = board
      score = call_maxing_or_not_max(new_board, depth, min)
      board[i][j] = " "
      best_score = min_or_max([score, best_score], min)
    end
    best_score
  end

  def maxing(board, depth)
    score = game_score(board)
    return score/depth if score
    best_score = -Float::INFINITY
    board.each_with_index do |row, i|
      board.each_with_index do |cell, j|
        best_score = get_score(board, best_score, depth ,ai_player, false, i, j)
      end
    end
    best_score
  end


  def not_maxing(board, depth)
    score = game_score(board)
    return score/depth if score
    best_score = Float::INFINITY
    board.each_with_index do |row, i|
      board.each_with_index do |col, j|
        best_score = get_score(board, best_score, depth, human_player, true, i, j)
      end
    end
    best_score
  end


  def return_best_move(board)
    best_score = -Float::INFINITY
    best_move = nil
    return [0, 0] if @game.board_empty?(board)
    board.each_with_index do |row, i|
      board.each_with_index do |col, j|
        if board[i][j] == " "
          board[i][j] = ai_player
          new_board = board
          score = not_maxing(new_board, 1)
          board[i][j] = " "
          if score > best_score
            best_score = score
            best_move = [i, j]
          end
        end
      end
    end
    best_move
  end

end