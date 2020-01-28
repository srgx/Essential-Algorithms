require_relative 'exercise5.rb'
# Exercise 6



def deleteDouble(targetCell)
  targetCell.previous.next=targetCell.next # left cell right link
  targetCell.next.previous=targetCell.previous # right cell left link
end

def testDelete(top,target)
  l=len(top)
  deleteDouble(target)
  return len(top)==l-1
end

topSentinel=DoubleCell.new(Float::INFINITY)
bottomSentinel=DoubleCell.new(Float::INFINITY)
topSentinel.next=bottomSentinel
bottomSentinel.previous=topSentinel
[12,34,35,28,7,3].each { |i| addAtBeginningDouble(topSentinel,DoubleCell.new(i)) }
addAtBottom(bottomSentinel,DoubleCell.new(123))
cellToDel=DoubleCell.new(2)
addAtBottom(bottomSentinel,cellToDel)
addAtBottom(bottomSentinel,DoubleCell.new(77))
raise ERR unless(testDelete(topSentinel,cellToDel))
