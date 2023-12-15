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

  def row_win?
    if left == middle && left == right
      true
    else
      false
    end
  end

  def column_win?(row2, row3)
    instance_variables.each do |location|
      self_location = instance_variable_get(location)
      if self_location == row2.instance_variable_get(location) && self_location == row3.instance_variable_get(location)
        true
      end
    end
    false
  end

  def cross_win?(row2, row3)
    if left == row2.middle && left == row3.right
      true
    elsif right == row2.middle && right == row3.left
      true
    else
      false
    end
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
    choice = gets.chomp.to_i
    while choice.zero?
      p 'Please put an integer'
      choice = gets.chomp.to_i
    end
    choice
  end

  def check_winner(rows)
    rows.each do |row|
      return true if row.row_win?
    end
    return true if rows[0].column_win?(rows[1], rows[2])
    return unless rows[0].cross_win?(rows[1], rows[2])

    true
  end

  def run_game
    while winner == false
      players.each do |player|
        make_move(input('Pick a spot: '), player)
        winner = check_winner(rows)
        return declare_winner(player) if winner == true

        show_board
      end
    end
  end

  def declare_winner(player)
    p "Congrats #{player.player_name}!"
    show_board
  end

  def rows_array
    indexed_rows = []
    rows.map do |row|
      row.instance_variables.each do |location|
        indexed_rows.push(row.instance_variable_get(location))
      end
    end
    indexed_rows
  end

  def check_false_input(choice)
    choice = input('Try again: ') while rows_array[choice.to_f - 1] == 'x' || rows_array[choice.to_f - 1] == 'o'
    choice
  end

  def make_move(choice, player)
    choice = check_false_input(choice)
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
game.run_game
