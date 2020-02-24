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
    @left = Marshal.load(Marshal.dump(other.left))
    @right = Marshal.load(Marshal.dump(other.right))
    @diff = other.diff
  end

  def <(other)
    return @diff<other.diff
  end

  def perfect?
    return @diff.zero?
  end
end

def exhaustivePartition(items,index,maxIndex,solution,shortC)
  if(index>maxIndex)
    return Solution.new(solution) # save as new object
  else
    solution.pushLeft(items[index])
    leftBest = exhaustivePartition(items,index+1,maxIndex,solution,shortC)
    solution.popLeft

    # short circuit
    if(shortC)
      return leftBest if leftBest.perfect?
    end

    solution.pushRight(items[index])
    rightBest = exhaustivePartition(items,index+1,maxIndex,solution,shortC)
    solution.popRight

    return leftBest<rightBest ? leftBest : rightBest
  end
end

def randomPartition(low,up,size,shortCircuit)
  items = []
  size.times { items << rand(low..up) }
  result = exhaustivePartition(items,0,size-1,Solution.new,shortCircuit)
  print "Left side: "
  p result.left
  print "Right side: "
  p result.right
  print "Difference: "
  p result.diff
end

# randomPartition(0,100,5,true)
