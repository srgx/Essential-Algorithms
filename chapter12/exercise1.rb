require 'matrix'
# Exercise 1
# Write a program that exhaustively searches the tic-tac-toe game
# tree and counts the number of times X wins, O wins, and the game
# ends in a tie. What are those counts, and what is the total
# number of games possible? Do the numbers give an advantage to one
# player or the other?


class Board
  attr_accessor :arr
  def initialize
    @arr = []
    3.times do
      @arr << [nil,nil,nil]
    end
  end

  def checkCols(symbol)
    for i in 0..2
      if(@arr[0][i]==symbol&&@arr[1][i]==symbol&&@arr[2][i]==symbol)
        return true
      end
    end
    return false
  end

  def checkDiagonals(symbol)
    if(@arr[0][0]==symbol&&@arr[1][1]==symbol&&@arr[2][2]==symbol)
      return true
    elsif(@arr[0][2]==symbol&&@arr[1][1]==symbol&&@arr[2][0]==symbol)
      return true
    else
      return false
    end
  end

  def win?(symbol)
    row = Array.new(3,symbol)
    if(@arr[0]==row&&@arr[1]==row&&@arr[2]==row) # rows
      return true
    elsif(checkCols(symbol)) # cols
      return true
    elsif(checkDiagonals(symbol)) # diagonals
      return true
    else
      return false
    end
  end

  def draw?
    return self.allOccupied? && !self.win?("X") && !self.win("O")
  end

  def allOccupied?
    for i in 0..2
      for j in 0..2
        if(@arr[i][j].nil?)
          return false
        end
      end
    end
    return true
  end
end

def exhaustiveSearch(board,player,xWins,oWins,draws)
  if(board.win?("X"))
    return [xWins+1,oWins,draws]
  elsif(board.win?("O"))
    return [xWins,oWins+1,draws]
  elsif(board.allOccupied?)
    return [xWins,oWins,draws+1]
  else
    result = [0,0,0]
    for i in 0..2
      for j in 0..2
        if(board.arr[i][j].nil?)
          board.arr[i][j] = player
          player = player=="X" ? "O" : "X"
          res = exhaustiveSearch(board,player,xWins,oWins,draws)
          result = result.zip(res).map { |a, b| a + b }
          board.arr[i][j] = nil
        end
      end
    end
    return result
  end
end

board = Board.new

result = exhaustiveSearch(board,"X",0,0,0)
puts "X: #{result[0]}"
puts "O: #{result[1]}"
puts "Draws: #{result[2]}"
puts "Games: #{result.sum}"
