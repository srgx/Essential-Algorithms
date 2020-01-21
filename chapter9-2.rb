# Exercise 12

CHB_SIZE = 8

def findTopLeft(row,col)
  if(col>=row)
    currentRow=0
    currentCol=col-row
  else
    currentRow=row-col
    currentCol=0
  end
  return [currentRow,currentCol]
end

def findBotLeft(row,col)
  cr = col+row
  max_indx = CHB_SIZE-1
  if(cr<=max_indx)
    currentRow=cr
    currentCol=0
  else
    currentRow=max_indx
    currentCol=cr-max_indx
  end
  return [currentRow,currentCol]
end


def checkTopLeftDiagonal(row,col,spots_taken)
  r = findTopLeft(row,col)
  currentRow,currentCol = r[0],r[1]
  while(currentRow<CHB_SIZE&&currentCol<CHB_SIZE)
    if(spots_taken[currentRow][currentCol]&&
       currentRow!=row&&currentCol!=col)
      return false
    end
    currentRow+=1
    currentCol+=1
  end
  return true
end

def checkBotLeftDiagonal(row,col,spots_taken)
  r = findBotLeft(row,col)
  currentRow,currentCol = r[0],r[1]

  while(currentRow>=0&&currentCol<CHB_SIZE)
    if(spots_taken[currentRow][currentCol]&&
       currentRow!=row&&currentCol!=col)
      return false
    end
    currentRow-=1
    currentCol+=1
  end
  return true
end

def checkDiagonals(row,col,spots_taken)
  return checkTopLeftDiagonal(row,col,spots_taken)&&
         checkBotLeftDiagonal(row,col,spots_taken)
end

def checkRow(row,col,spots_taken)
  0.upto(CHB_SIZE-1) do |c|
    if(c!=col&&spots_taken[row][c])
      return false
    end
  end
  return true
end

def checkCol(row,col,spots_taken)
  0.upto(CHB_SIZE-1) do |r|
    if(r!=row&&spots_taken[r][col])
      return false
    end
  end
  return true
end

def checkRowCol(row,col,spots_taken)
  return checkRow(row,col,spots_taken)&&
         checkCol(row,col,spots_taken)
end

def is_one_legal(row,col,spots_taken)
  return !spots_taken[row][col]||
          checkRowCol(row,col,spots_taken)&&
          checkDiagonals(row,col,spots_taken)
end

# check every spot separately
def is_legal(spots_taken)
  0.upto(CHB_SIZE-1) do |row|
    0.upto(CHB_SIZE-1) do |col|
      if(!is_one_legal(row,col,spots_taken))
        return false
      end
    end
  end
  return true
end

def checkAllCols(spots_taken)
  0.upto(CHB_SIZE-1) do |row|
    inrow=0
    0.upto(CHB_SIZE-1) do |col|
      if(spots_taken[row][col]==true)
        inrow+=1
        if(inrow>1) then return false end
      end
    end
  end
  return true
end

def checkAllRows(spots_taken)
  0.upto(CHB_SIZE-1) do |col|
    incol=0
    0.upto(CHB_SIZE-1) do |row|
      if(spots_taken[row][col]==true)
        incol+=1
        if(incol>1) then return false end
      end
    end
  end
  return true
end

def checkAllDiagonals(spots_taken)
  # topleft diagonal from left border
  0.upto(CHB_SIZE-1) do |row|
    currentRow = row
    currentCol = 0
    indiag = 0
    while(currentRow<CHB_SIZE&&currentCol<CHB_SIZE)
      if(spots_taken[currentRow][currentCol])
        indiag+=1
        if(indiag>1) then return false end
      end
      currentRow+=1
      currentCol+=1
    end
  end

  # topleft diagonal from top border
  1.upto(CHB_SIZE-1) do |col|
    currentRow = 0
    currentCol = col
    indiag = 0
    while(currentRow<CHB_SIZE&&currentCol<CHB_SIZE)
      if(spots_taken[currentRow][currentCol])
        indiag+=1
        if(indiag>1) then return false end
      end
      currentRow+=1
      currentCol+=1
    end
  end

  # botleft diagonal from left border
  0.upto(CHB_SIZE-1) do |row|
    currentRow = row
    currentCol = 0
    indiag = 0
    while(currentRow>=0&&currentCol<CHB_SIZE)
      if(spots_taken[currentRow][currentCol])
        indiag+=1
        if(indiag>1) then return false end
      end
      currentRow-=1
      currentCol+=1
    end
  end

  # botleft diagonal from bot border
  1.upto(CHB_SIZE-1) do |col|
    currentRow = CHB_SIZE-1
    currentCol = col
    indiag = 0
    while(currentRow>=0&&currentCol<CHB_SIZE)
      if(spots_taken[currentRow][currentCol])
        indiag+=1
        if(indiag>1) then return false end
      end
      currentRow-=1
      currentCol+=1
    end
  end
  return true
end

# check all board at once
def is_legal_total(spots_taken)
  unless(checkAllCols(spots_taken)&&
         checkAllRows(spots_taken)&&
         checkAllDiagonals(spots_taken))
         return false
  end
  return true
end

# danger=1 for adding, danger=-1 for removing
def place_queen(row,col,spots_taken,danger=1)

  if(danger!=1&&danger!=-1)
    raise "1 or -1 for danger parameter"
  end

  if(danger==-1)
    spots_taken[row][col] = 4 # after 4 passes value is 0
  end

  # add or remove horizontal danger
  0.upto(CHB_SIZE-1) do |c|
    spots_taken[row][c]+=danger
  end

  # add or remove vertical danger
  0.upto(CHB_SIZE-1) do |r|
    spots_taken[r][col]+=danger
  end

  # add or remove botleft diagonal danger
  r = findBotLeft(row,col)
  currentRow,currentCol = r[0],r[1]
  while(currentRow>=0&&currentCol<CHB_SIZE)
    spots_taken[currentRow][currentCol]+=danger
    currentRow-=1
    currentCol+=1
  end

  # add or remove topleft diagonal danger
  r = findTopLeft(row,col)
  currentRow,currentCol = r[0],r[1]
  while(currentRow<CHB_SIZE&&currentCol<CHB_SIZE)
    spots_taken[currentRow][currentCol]+=danger
    currentRow+=1
    currentCol+=1
  end

  if(danger==1)
    spots_taken[row][col] = true
  end
end

def remove_queen(row,col,spots_taken)
  place_queen(row,col,spots_taken,-1)
end

# spot is true or false
def eightQueens(spots_taken,num_queens_positioned)
  if(num_queens_positioned==CHB_SIZE)
    return true
  else
    0.upto(CHB_SIZE-1) do |row|
      0.upto(CHB_SIZE-1) do |col|
        if(!spots_taken[row][col])
          spots_taken[row][col]=true
          # use is_legal(slower) or is_legal_total(faster)
          if(is_legal_total(spots_taken)&&eightQueens(spots_taken,num_queens_positioned + 1))
            return true
          else
            spots_taken[row][col]=false
          end
        end
      end
    end
    return false
  end
end

# spot is true or number of attacking queens
def betterEightQueens(spots_taken,num_queens_positioned)
  if(num_queens_positioned==CHB_SIZE)
    return true
  else
    0.upto(CHB_SIZE-1) do |row|
      0.upto(CHB_SIZE-1) do |col|
        if(spots_taken[row][col]==0)
          place_queen(row,col,spots_taken)
          if(betterEightQueens(spots_taken,num_queens_positioned + 1))
            return true
          else
            remove_queen(row,col,spots_taken)
          end
        end
      end
    end
    return false
  end
end

# spot is true or number of attacking queens
def bestEightQueens(spots_taken,num_queens_positioned)
  if(num_queens_positioned==CHB_SIZE)
    return true
  else
    0.upto(CHB_SIZE-1) do |col|
      if(spots_taken[num_queens_positioned][col]==0)
        place_queen(num_queens_positioned,col,spots_taken)
        if(bestEightQueens(spots_taken,num_queens_positioned + 1))
          return true
        else
          remove_queen(num_queens_positioned,col,spots_taken)
        end
      end
    end
    return false
  end
end


def showResult(spots_taken)
  spots_taken.each do |row|
    row.each do |p|
      if(p)
        print "X"
      else
        print "O"
      end
    end
    puts
  end
end

def showResult2(spots_taken)
  spots_taken.each do |row|
    row.each do |p|
      if(true==p)
        print "X"
      elsif(p>0)
        print "!"
      else
        print " "
      end
    end
    puts
  end
end

def runQueens1
  spots_taken = Array.new(CHB_SIZE)
  0.upto(CHB_SIZE-1) { |i| spots_taken[i] = Array.new(CHB_SIZE,false) }

  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  eightQueens(spots_taken,0)
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "First Version: #{ending-starting}"

  showResult(spots_taken)
end


def runQueens2
  spots_taken = Array.new(CHB_SIZE)
  0.upto(CHB_SIZE-1) { |i| spots_taken[i] = Array.new(CHB_SIZE,0) }

  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  betterEightQueens(spots_taken,0)
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Second Version: #{ending-starting}"

  showResult2(spots_taken)
end

def runQueens3
  spots_taken = Array.new(CHB_SIZE)
  0.upto(CHB_SIZE-1) { |i| spots_taken[i] = Array.new(CHB_SIZE,0) }

  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  bestEightQueens(spots_taken,0)
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Third Version: #{ending-starting}"

  showResult2(spots_taken)
end

#runQueens1
#runQueens2
#runQueens3

# ----------------------------------------------------------------
raise ERR if(findTopLeft(0,0)!=[0,0])
raise ERR if(findTopLeft(2,1)!=[1,0])
raise ERR if(findTopLeft(3,5)!=[0,2])
raise ERR if(findTopLeft(3,3)!=[0,0])
raise ERR if(findBotLeft(2,1)!=[3,0])
raise ERR if(findBotLeft(3,3)!=[6,0])
raise ERR if(findBotLeft(5,6)!=[7,4])
raise ERR if(findBotLeft(6,4)!=[7,3])
