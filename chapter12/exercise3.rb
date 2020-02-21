require_relative 'exercise2.rb'
# Exercise 3

def randomMove(board,symbol)
  xy = getXY(rand(1..9))
  while(!board[xy[0]][xy[1]].nil?)
    xy = getXY(rand(1..9))
  end
  board[xy[0]][xy[1]] = symbol
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
