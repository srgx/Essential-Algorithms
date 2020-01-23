# Exercise 15

DROWS = [-2,-2,-1,1,2,2,1,-1]
DCOLS = [-1,1,2,2,1,-1,-2,-2]

class Move
  attr_reader :row, :col, :moves
  def initialize(r,c,m)
    @row, @col, @moves = r, c, m
  end

  def <(other)
    return @moves<other.moves
  end
end

def knightsTour(row,col,moveNumber,numMovesTaken,numRows,numCols)
  numMovesTaken+=1
  moveNumber[row][col] = numMovesTaken

  if(numMovesTaken==numRows*numCols) then return true end

  0.upto(7) do |i|
    r = row + DROWS[i]
    c = col + DCOLS[i]
    if((r>=0)&&(r<numRows)&&
       (c>=0)&&(c<numCols)&&(moveNumber[r][c]==0))
       if(knightsTour(r,c,moveNumber,numMovesTaken,numRows,numCols))
         return true
       end
    end
  end
  moveNumber[row][col] = 0
  return false
end

def runTour(numRows,numCols)
  arr = Array.new(numRows)
  0.upto(arr.size-1) do |i|
    arr[i] = Array.new(numCols,0)
  end
  knightsTour(0,0,arr,0,numRows,numCols)
  arr.each do |a|
    p a
  end
end

# Exercise 16

def countMoves(row,col,moveNumber,numRows,numCols)
  moves = 0
  0.upto(7) do |i|
    r = row + DROWS[i]
    c = col + DCOLS[i]
    if((r>=0)&&(r<numRows)&&
       (c>=0)&&(c<numCols)&&(moveNumber[r][c]==0))
       moves+=1
    end
  end
  return moves
end

def warnsdorf(row,col,moveNumber,numMovesTaken,numRows,numCols)
  numMovesTaken+=1
  moveNumber[row][col] = numMovesTaken
  if(numMovesTaken==numRows*numCols) then return true end

  pm = [] # possible moves
  0.upto(7) do |i|
    r = row + DROWS[i]
    c = col + DCOLS[i]
    if((r>=0)&&(r<numRows)&&
       (c>=0)&&(c<numCols)&&(moveNumber[r][c]==0))
       moves = countMoves(r,c,moveNumber,numRows,numCols)
       pm << Move.new(r,c,moves)
    end
  end

  if(pm.size.zero?) then raise "NO SOLUTION" end

  min = pm[0]
  0.upto(pm.size-1) do |i|
    if(pm[i]<min)
      min = pm[i]
    end
  end
  warnsdorf(min.row,min.col,moveNumber,numMovesTaken,numRows,numCols)
end

def runWarnsdorf(numRows,numCols)
  arr = Array.new(numRows)
  0.upto(arr.size-1) do |i|
    arr[i] = Array.new(numCols,0)
  end
  warnsdorf(0,0,arr,0,numRows,numCols)
  arr.each do |a|
    p a
  end
end

=begin
runTour(5,5)
puts "-------------------------"
runWarnsdorf(5,5)
=end