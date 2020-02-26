# Exercise 4

class Solution
  attr_reader :left, :right, :diff
  def initialize(sol=nil)
    if(!sol.nil?)
      self.cp(sol)
    else
      @left, @right = [], []
      @diff = Float::INFINITY
    end
  end

  def setDiff
    @diff = (@left.sum-@right.sum).abs
  end

  def pushLeft(item)
    @left.push(item)
    self.setDiff
  end

  def pushRight(item)
    @right.push(item)
    self.setDiff
  end

  def popLeft
    @left.pop
    self.setDiff
  end

  def popRight
    @right.pop
    self.setDiff
  end

  def cp(other)
    @left = other.left.clone
    @right = other.right.clone
    @diff = other.diff
  end

  def <(other)
    return @diff<other.diff
  end

  def perfect?
    return @diff.zero?
  end

  def show
    print "Left side: "
    p @left
    print "Right side: "
    p @right
    print "Difference: "
    p @diff
  end
end

def startExhaustivePartition(items,circuit)
  $bestSolution = Solution.new
  currentSolution = Solution.new
  $nodesVisited = 0
  exhaustivePartition(items,0,items.size-1,currentSolution,circuit)
  return [$bestSolution,$nodesVisited]
end

def exhaustivePartition(items,index,maxIndex,solution,circuit)
  $nodesVisited+=1
  if(index>maxIndex)
    if(solution<$bestSolution)
      $bestSolution.cp(solution)
    end
  else
    solution.pushLeft(items[index])
    exhaustivePartition(items,index+1,maxIndex,solution,circuit)
    solution.popLeft

    # short circuit
    if(circuit)
      return $bestSolution if $bestSolution.perfect?
    end

    solution.pushRight(items[index])
    exhaustivePartition(items,index+1,maxIndex,solution,circuit)
    solution.popRight
  end
end

def randomPartition(low,up,size,circuit)
  items = []
  size.times { items << rand(low..up) }
  result = startExhaustivePartition(items,circuit)
  result[0].show
end

# randomPartition(0,100,10,true)
