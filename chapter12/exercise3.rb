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
    self.set(x,y)
  end

  def set(x,y)
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
    bestValue.value = 3
    return
  end
  lowestValue = Float::INFINITY
  lowestMove = Move.new
  for i in 0..2
    for j in 0..2
      if(board[i][j].nil?)
        board[i][j] = player1
        if(board.win?(player1))
          lowestValue = 1
          lowestMove.set(i,j)
        elsif(board.win?(player2))
          lowestValue = 4
          lowestMove.set(i,j)
        elsif(board.full?)
          lowestValue = 2
          lowestMove.set(i,j)
        else
          testValue = Value.new
          testMove = Move.new(i,j)
          miniMax(board,testMove,testValue,player2,player1,depth+1,maxDepth)
          if(testValue.value<lowestValue)
            lowestValue = testValue.value
            lowestMove.set(i,j)
          end
        end
        board[i][j] = nil
      end
    end
  end
  bestMove.cp(lowestMove)
  if(lowestValue == 4)
    bestValue.value = 1
  elsif(lowestValue == 1)
    bestValue.value = 4
  else
    bestValue.value = lowestValue
  end
end


def playTurn(symbol,player,board,level)
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
    if(level==0)
      randomMove(board,symbol)
    elsif(level==1)
      mov, val = Move.new, Value.new
      miniMax(board,mov,val,symbol,swp(symbol),0,3)
      board[mov.x][mov.y] = symbol
    elsif(level==2)
      mov, val = Move.new, Value.new
      miniMax(board,mov,val,symbol,swp(symbol),0,9)
      board[mov.x][mov.y] = symbol
    else
      raise "Nieprawidłowy poziom trudności"
    end
  end
end


def playGame
  board = Board.new
  winner = nil

  print "Wybierz poziom trudności(0, 1, 2): "
  level = gets.chomp.to_i
  while(level!=0&&level!=1&&level!=2)
    print "Nieprawidłowy wybór. Możliwe opcje (0, 1, 2): "
    level = gets.chomp.to_i
  end

  print "Wybierz X albo O: "
  player = gets.chomp.upcase
  while(player!="X"&&player!="O")
    print "Nieprawidłowy wybór. Możliwe opcje (X,O): "
    player = gets.chomp.upcase
  end

  loop do

    playTurn("X",player,board,level)
    board.show

    if(board.win?("X"))
      winner = "X"
      break
    elsif(board.full?)
      break
    end

    playTurn("O",player,board,level)
    board.show

    if(board.win?("O"))
      winner = "O"
      break
    elsif(board.full?)
      break
    end

  end

  puts winner=="X"||winner=="O" ? "Wygrywa gracz #{winner}!" : "Remis!"

end

# playGame
