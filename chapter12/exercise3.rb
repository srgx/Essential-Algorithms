require_relative 'exercise2.rb'
# Exercise 3

def randomMove(board,symbol)
  xy = getXY(rand(1..9))
  while(!board[xy[0]][xy[1]].nil?)
    xy = getXY(rand(1..9))
  end
  board[xy[0]][xy[1]] = symbol
end

class Value
  attr_accessor :value
  def initialize(v=nil)
    @value = v
  end

  def cp(other)
    @value = other.value
  end
end

class Move
  attr_accessor :x, :y
  def initialize(x=nil,y=nil)
    @x, @y = x, y
  end

  def cp(other)
    @x = other.x
    @y = other.y
  end
end

class Board
  def show
    for i in 0..2
      for j in 0..2
        if(@arr[i][j].nil?)
          print(i*3+j+1)
        else
          print(@arr[i][j])
        end
        print " "
      end
      puts
    end
  end
end


# values: 4 - win, 3 - unknown, 2 - draw, 1 - loss
def miniMax(board,bestMove,bestValue,player1,player2,depth,maxDepth)
  if(depth>maxDepth)
    return Value.new(3)
  end
  lowestValue = Float::INFINITY
  lowestMove = nil
  for i in 0..2
    for j in 0..2
      if(board[i][j].nil?)
        board[i][j] = player1
        if(board.win?(player1))
          lowestValue = 1
          lowestMove = Move.new(i,j)
        elsif(board.win?(player2))
          lowestValue= 4
          lowestMove = Move.new(i,j)
        elsif(board.full?)
          lowestValue = 2
          lowestMove = Move.new(i,j)
        else
          testValue = Float::INFINITY
          testMove = Move.new
          miniMax(board,testMove,testValue,player2,player1,depth+1,maxDepth)
          if(testValue<lowestValue)
            lowestValue = testValue
            lowestMove = testMove
          end
        end
        board[i][j] = nil
      end
    end
  end
  bestMove = lowestMove
  if(lowestValue == 4)
    bestValue = 1
  elsif(lowestValue == 1)
    bestValue = 4
  else
    bestValue = lowestValue
  end
end

board = Board.new
mov = Move.new
val = Value.new
miniMax(board,mov,val,"X","O",0,5)

puts "Ruch #{mov.x}-#{mov.y} ma wartość #{val.value}"


def playTurn(symbol,player,board)
  if(player==symbol)
    print "Podaj pozycję #{symbol}(1-9): "
    indx = gets.chomp.to_i
    xy = getXY(indx)
    while(!board[xy[0]][xy[1]].nil?)
      print "Pozycja zajęta! Podaj prawidłową wartość: "
      indx = gets.chomp.to_i
      xy = getXY(indx)
    end
    place(indx,player,board)
  else
    puts "Ruch komputera #{symbol}"
    randomMove(board,symbol)
  end
end
=begin
board = Board.new
winner = nil

print "Wybierz X albo O: "
player = gets.chomp.upcase
while(player!="X"&&player!="O")
  print "Nieprawidłowy wybór. Możliwe opcje (X,O): "
  player = gets.chomp.upcase
end


loop do

  playTurn("X",player,board)
  board.show

  if(board.win?("X"))
    winner = "X"
    break
  elsif(board.full?)
    break
  end

  playTurn("O",player,board)
  board.show

  if(board.win?("O"))
    winner = "O"
    break
  elsif(board.full?)
    break
  end

end

if(winner=="X"||winner=="O")
  puts "Wygrywa gracz #{winner}!"
else
  puts "Remis!"
end
=end
