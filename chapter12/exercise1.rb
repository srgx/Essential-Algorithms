require 'matrix'
# Exercise 1

class Board
  def initialize
    @arr = []
    3.times do
      @arr << [nil,nil,nil]
    end
  end

  def checkRows(symbol)
    row = Array.new(3,symbol)
    return @arr[0]==row||@arr[1]==row||@arr[2]==row
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
    return @arr[0][0]==symbol&&@arr[1][1]==symbol&&@arr[2][2]==symbol||
           @arr[0][2]==symbol&&@arr[1][1]==symbol&&@arr[2][0]==symbol
  end

  def win?(symbol)
    return checkRows(symbol)||
           checkCols(symbol)||
           checkDiagonals(symbol)
  end


  def full?
    for i in 0..2
      for j in 0..2
        if(@arr[i][j].nil?)
          return false
        end
      end
    end
    return true
  end

  def [](indx)
    return @arr[indx]
  end

end

def exhaustiveSearch(board,player)
  if(board.win?("X"))
    return Vector[1,0,0]
  elsif(board.win?("O"))
    return Vector[0,1,0]
  elsif(board.full?)
    return Vector[0,0,1]
  else
    result = Vector[0,0,0]
    for i in 0..2
      for j in 0..2
        if(board[i][j].nil?)
          board[i][j] = player
          result += exhaustiveSearch(board,player=="X"?"O":"X")
          board[i][j] = nil
        end
      end
    end
    return result
  end
end

=begin
board = Board.new
result = exhaustiveSearch(board,"X")
puts "X: #{result[0]}"
puts "O: #{result[1]}"
puts "Tie: #{result[2]}"
puts "Games: #{result.sum}"
=end
