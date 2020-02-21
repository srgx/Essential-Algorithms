require_relative 'exercise1.rb'
# Exercise 2

def getXY(index)
  indx = index-1
  return [indx/3,indx%3]
end

def place(index,symbol,board)
  indx = getXY(index)
  board[indx[0]][indx[1]] = symbol
end

# pusty wiersz kończy wprowadzanie
def fillBoard(board)
  puts "Podawaj pozycje pól(1-9)"
  current = "X"
  loop do
    print "Pozycja #{current}: "
    input = gets.chomp
    if(input=="") then return swp(current) end
    num = input.to_i
    place(num,current,board)
    if(board.full?) then return current end
    current = swp(current)
  end
  return current
end

=begin
board = Board.new
last = fillBoard(board)
result = exhaustiveSearch(board,swp(last))
puts "X: #{result[0]}"
puts "O: #{result[1]}"
puts "Tie: #{result[2]}"
puts "Games: #{result.sum}"
=end
