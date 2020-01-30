require_relative 'exercise12.rb'
# Exercise 13

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

def runQueens2
  spots_taken = Array.new(CHB_SIZE)
  0.upto(CHB_SIZE-1) { |i| spots_taken[i] = Array.new(CHB_SIZE,0) }

  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  betterEightQueens(spots_taken,0)
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Second Version: #{ending-starting}"

  showResult2(spots_taken)
end

# runQueens2
