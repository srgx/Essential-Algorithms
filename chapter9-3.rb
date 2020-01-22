# Exercise 15

def knightsTour(row,col,moveNumber,numMovesTaken,numRows,numCols)
  numMovesTaken+=1
  moveNumber[row][col] = numMovesTaken

  if(numMovesTaken==numRows*numCols) then return true end
  dRows = [-2,-2,-1,1,2,2,1,-1]
  dCols = [-1,1,2,2,1,-1,-2,-2]


  0.upto(7) do |i|
    r = row + dRows[i]
    c = col + dCols[i]
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

#runTour(4,5)
