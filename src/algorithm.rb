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

  def get_score(board, best_score , depth, player, min, row, col)
    if board[row][col] == " "
      board[row][col] = player
      new_board = board
      score = call_maxing_or_not_max(new_board, depth, min)
      board[row][col] = " "
      best_score = min_or_max([score, best_score], min)
    end
    best_score
  end

  def maxing(board, depth)
    score = game_score(board)
    return score/depth if score
    best_score = -Float::INFINITY
    board.each_with_index do |hor, row|
      board.each_with_index do |vert, col|
        best_score = get_score(board, best_score, depth ,ai_player, false, row, col)
      end
    end
    best_score
  end

  def not_maxing(board, depth)
    score = game_score(board)
    return score/depth if score
    best_score = Float::INFINITY
    board.each_with_index do |hor, row|
      board.each_with_index do |vert, col|
        best_score = get_score(board, best_score, depth, human_player, true, row, col)
      end
    end
    best_score
  end

  def return_best_move(board)
    best_score = -Float::INFINITY
    best_move = nil
    return [0, 0] if @game.board_empty?(board)
    board.each_with_index do |hor, row|
      board.each_with_index do |vert, col|
        if board[row][col] == " "
          board[row][col] = ai_player
          new_board = board
          score = not_maxing(new_board, 1)
          board[row][col] = " "
          if score > best_score
            best_score = score
            best_move = [row, col]
          end
        end
      end
    end
    best_move
  end

end