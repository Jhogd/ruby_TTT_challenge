require_relative 'algorithm'
require_relative 'util'

class Tic_Tac_Toe
  def initialize(human_player)
    size = 3
    @game = Game_Logic.new(size)
    @ai = Min_Max_Alg.new(@game, @game.switch_player(human_player))
  end

  def game
    @game
  end

  def ai
    @ai
  end

  def ending_message(winner)
    message = { (winner == @ai.ai_player) => "The Ai has won, sorry!", (winner == @ai.human_player) => "You have won!!", (winner == " ") => "The game is a draw" }
    message[true]
  end

  def player_turn_message(player)
    message = { (player == @ai.ai_player) => "The Ai is choosing a move", (player == @ai.human_player) => "Please enter a valid move i.e 0 0, 1 1, etc.." }
    message[true]
  end

  def self.select_player
    puts "Please enter a 1 or 2 to choose your player\n 1) X\n 2) O"
    player_selector = { "1" => "X", "2" => "O" }
    choice = gets
    player_selector.fetch(choice.strip)
  end

  def get_move(player, board)
    if player == ai.ai_player
      ai.return_best_move(board)
    else
      game.parse_user_input(gets)
    end
  end

  def check_move!(player)
    move = get_move(player, game.board)
    if game.valid_move?(move, game.board)
      move
    else
      puts "Invalid Move! please try again"
      check_move!(player)
    end
  end

  def play_game
    player = game.current_player
    puts "The Ai will act as player #{ai.ai_player} good luck!"
    puts game.display_board(game.board)
    loop do
      winner = game.terminal(game.board)
      if winner
        puts ending_message(winner)
        break
      end
      puts player_turn_message(player)
      valid_move = check_move!(player)
      game.make_move!(player, valid_move[0], valid_move[1])
      puts game.display_board(game.board)
      player = game.switch_player(player)
    end
  end

end

if $0 == __FILE__
  new_game = Tic_Tac_Toe.new(Tic_Tac_Toe.select_player)
  new_game.play_game
end