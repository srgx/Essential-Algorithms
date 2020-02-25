require_relative 'exercise4.rb'
# Exercise 5

def sumFrom(arr,index)
  sum = 0
  for i in index...arr.size
    sum += arr[i]
  end
  return sum
end

def startBranchAndBound(items,circuit)
  $bestSolution = Solution.new
  currentSolution = Solution.new
  $nodesVisited = 0
  branchAndBound(items,0,items.size-1,currentSolution,circuit)
  return [$bestSolution,$nodesVisited]
end

def branchAndBound(items,index,maxIndex,solution,circuit)
  $nodesVisited+=1
  if(index>maxIndex)
    if(solution<$bestSolution)
      $bestSolution.cp(solution)
    end
  else
    currentDiff = solution.diff
    bestDiff = $bestSolution.diff
    unassignedSum = sumFrom(items,index)

    # stop searching if bestDiff is better or equal
    # than the best possible improvement for this branch,
    # dont allow algorithm to stop at index 0 where
    # both diffs are equal Float::INFINITY
    return if(bestDiff<=currentDiff-unassignedSum&&index!=0)

    solution.pushLeft(items[index])
    branchAndBound(items,index+1,maxIndex,solution,circuit)
    solution.popLeft

    # short circuit
    if(circuit)
      return $bestSolution if $bestSolution.perfect?
    end

    solution.pushRight(items[index])
    branchAndBound(items,index+1,maxIndex,solution,circuit)
    solution.popRight

  end
end

# items = []
# 10.times { items << rand(1..1000)}
# result = startBranchAndBound(items,true)
# result[0].show
