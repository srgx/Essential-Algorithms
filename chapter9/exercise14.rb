require_relative 'exercise13.rb'
# Exercise 14

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


def runQueens3
  spots_taken = Array.new(CHB_SIZE)
  0.upto(CHB_SIZE-1) { |i| spots_taken[i] = Array.new(CHB_SIZE,0) }

  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  bestEightQueens(spots_taken,0)
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Third Version: #{ending-starting}"

  showResult2(spots_taken)
end

# runQueens3
