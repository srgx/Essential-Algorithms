require_relative 'exercise4.rb'
# Exercise 7

def randomHeuristic(items,numTrials)
  maxIndex = items.size-1
  $bestSolution = Solution.new
  for i in 1..numTrials
    $currentSolution = Solution.new
    for index in 0..maxIndex
      choice = rand(0..1)
      if(choice.zero?)
        $currentSolution.pushLeft(items[index])
      else
        $currentSolution.pushRight(items[index])
      end
    end
    if($currentSolution<$bestSolution)
      $bestSolution.cp($currentSolution)
    end
  end
  return $bestSolution
end

=begin
items = []
for i in 1..25
  items << i
end
result = randomHeuristic(items,100)
result.show
=end
