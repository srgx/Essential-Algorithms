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

# Exercise 17
# Rearranged selections are permutations

# Exercise 18

def SelectKofNwithDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    start = 0
    if(index>0) then start = selections[index-1] end
    start.upto(items.size-1) do |i|
      selections[index] = i
      SelectKofNwithDuplicates(index+1,selections,items,results)
    end
  end
end

def SelectKofNwithoutDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    start = 0
    if(index>0) then start = selections[index-1] + 1 end
    start.upto(items.size-1) do |i|
      selections[index] = i
      SelectKofNwithoutDuplicates(index+1,selections,items,results)
    end
  end
end


# Exercise 19

def PermuteKofNwithDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    0.upto(items.size-1) do |i|
      selections[index] = i
      PermuteKofNwithDuplicates(index+1,selections,items,results)
    end
  end
end


def PermuteKofNwithoutDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    0.upto(items.size-1) do |i|
      used = false
      0.upto(index-1) do |j|
        if(selections[j] == i) then used = true end
      end
      if(!used)
        selections[index] = i
        PermuteKofNwithoutDuplicates(index+1,selections,items,results)
      end
    end
  end
end

# Exercise 20

def factorial(n)
  result = 1
  while(n!=0)
    result *= n
    n-=1
  end
  return result
end

# Exercise 21

def initFibo
  $fiboValues = Array.new(100)
  $fiboValues[0] = 0
  $fiboValues[1] = 1
  $maxN = 1
end

def fibo(n)
  if($maxN<n)
    $fiboValues[n] = fibo(n-1) + fibo(n-2)
    $maxN = n
  end
  return $fiboValues[n]
end

# Exercise 22

def nonRecFibo(n)
  if(n>$maxN)
    ($maxN+1).upto(n) do |i|
      $fiboValues[i] = nonRecFibo(i-1) + nonRecFibo(i-2)
    end
    $maxN = n
  end
  return $fiboValues[n]
end

# Exercise 23

def nonRecFiboLast(n)
  s, b, result = 0, 1, 0
  2.upto(n) do |i|
    result = s + b
    s, b = b, result
  end
  return result
end

def testFibos(n,tests)
  initFibo
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  tests.times { fibo(n) }
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Fibo1: #{ending-starting}"


  initFibo
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  tests.times { nonRecFibo(n) }
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Fibo2: #{ending-starting}"

  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  tests.times { nonRecFiboLast(n) }
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Fibo3: #{ending-starting}"
end

#testFibos(1000,1000)

# TESTS
# ---------------------------------
ERR = "Error"

# SELECTIONS
a = []
b = []
SelectKofNwithDuplicates(0,Array.new(2,0),[4,5,6],b)
raise ERR if b!= [[4, 4], [4, 5], [4, 6], [5, 5], [5, 6], [6, 6]]

a = []
b = []
SelectKofNwithoutDuplicates(0,Array.new(2,0),[4,5,6],b)
raise ERR if b!= [[4, 5], [4, 6], [5, 6]]

# PERMUTATIONS
a = []
b = []
PermuteKofNwithDuplicates(0,Array.new(3,0),[4,5,6],b)
raise ERR if b!= [[4, 4, 4], [4, 4, 5], [4, 4, 6],
                  [4, 5, 4], [4, 5, 5], [4, 5, 6],
                  [4, 6, 4], [4, 6, 5], [4, 6, 6],
                  [5, 4, 4], [5, 4, 5], [5, 4, 6],
                  [5, 5, 4], [5, 5, 5], [5, 5, 6],
                  [5, 6, 4], [5, 6, 5], [5, 6, 6],
                  [6, 4, 4], [6, 4, 5], [6, 4, 6],
                  [6, 5, 4], [6, 5, 5], [6, 5, 6],
                  [6, 6, 4], [6, 6, 5], [6, 6, 6]]

a = []
b = []
PermuteKofNwithoutDuplicates(0,Array.new(3,0),[4,5,6],b)
raise ERR if b != [[4, 5, 6], [4, 6, 5],
                   [5, 4, 6], [5, 6, 4],
                   [6, 4, 5], [6, 5, 4]]


# FIBONACCI
initFibo
raise ERR if fibo(7)!=13
initFibo
raise ERR if nonRecFibo(7)!=13
