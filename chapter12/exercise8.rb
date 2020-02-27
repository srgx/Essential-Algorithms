require_relative 'exercise7.rb'
# Exercise 8

def makeImprovements(items,numTrials)
  maxIndex = items.size-1
  bestSolution = Solution.new
  for i in 1..numTrials
    # create random solution
    currentSolution = createRandomSolution(items)
    hadImprovement = true
    while(hadImprovement)
      hadImprovement = false
      for index in 0..maxIndex
        # save solution before change
        original = Solution.new(currentSolution)
        # move current item left or right
        if(!(indx=currentSolution.left.index(items[index])).nil?)
          currentSolution.moveRight(indx)
        else
          indx=currentSolution.right.index(items[index])
          currentSolution.moveLeft(indx)
        end
        # check improvement
        if(currentSolution<original)
          hadImprovement = true
        else
          # restore original solution
          currentSolution.cp(original)
        end
      end
    end
    bestSolution.cp(currentSolution) if currentSolution<bestSolution
  end
  return bestSolution
end

=begin
items = []
for i in 1..100
  items << i
end
result = makeImprovements(items,20)
result.show
=end
