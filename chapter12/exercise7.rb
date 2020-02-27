require_relative 'exercise4.rb'
# Exercise 7

def createRandomSolution(items)
  solution = Solution.new
  maxIndex = items.size-1
  for index in 0..maxIndex
    choice = rand(0..1)
    if(choice.zero?)
      solution.pushLeft(items[index])
    else
      solution.pushRight(items[index])
    end
  end
  return solution
end

def randomHeuristic(items,numTrials)
  bestSolution = Solution.new
  for i in 1..numTrials
    currentSolution = createRandomSolution(items)
    if(currentSolution<bestSolution)
      bestSolution.cp(currentSolution)
    end
  end
  return bestSolution
end

=begin
items = []
for i in 1..25
  items << i
end
result = randomHeuristic(items,100)
result.show
=end
