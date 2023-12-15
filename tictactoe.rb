# frozen_string_literal: true

# each row of tictactoe
class GameRows
  attr_accessor :left, :middle, :right

  def initialize(left, middle, right)
    @left = left
    @middle = middle
    @right = right
  end

  def make_row
    "#{left} | #{middle} | #{right}"
  end
end

# sets up the board game
class TicTacToe
  attr_accessor :winner, :players, :rows

  def initialize(players, rows)
    @winner = false
    @players = players
    @rows = rows
  end

  def show_board
    rows.each_with_index do |row, index|
      if rows.size - 1 == index
        puts "#{row.make_row} \n"
      else
        puts "#{row.make_row} \n--+---+--"
      end
    end
  end

  def input(*args)
    print(*args)
    gets.chomp
  end

  def run_game
    while winner == false
      players.each do |player|
        make_move(input('Pick a spot'), player)
        puts declare_winner if winner != false
        show_board
      end
    end
  end

  def declare_winner; end

  def make_move(choice, player)
    rows.each do |row|
      row.instance_variables.each do |location|
        if row.instance_variable_get(location) == choice.to_s
          row.instance_variable_set(location, player.player_icon)
          break
        end
      end
    end
  end
end

# set up the players
class Players
  attr_accessor :player_name, :player_icon

  def initialize(player_name, player_icon)
    @player_name = player_name
    @player_icon = player_icon
  end
end

puts 'Player One, enter your name: '
# player_one_name = gets.chomp

player_one_name = 'Lucas'

player_one = Players.new(player_one_name, 'x')

puts 'Player Two, enter your name: '
# player_two_name = gets.chomp

player_two_name = 'Computer'

player_two = Players.new(player_two_name, 'o')

players = [player_one, player_two]

row_one = GameRows.new('1', '2', '3')
row_two = GameRows.new('4', '5', '6')
row_three = GameRows.new('7', '8', '9')

rows = [row_one, row_two, row_three]

game = TicTacToe.new(players, rows)

game.show_board
# game.make_move(game.input('Pick a spot'), player_one)
game.make_move(1, player_one)
game.show_board
