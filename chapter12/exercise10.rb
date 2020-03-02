# Exercise 10

def hillClimbing(items)
  maxIndex = items.size-1
  left, right = [], []
  for i in 0..maxIndex
    currentWeight = items[i]
    diff1 = ((left.sum + currentWeight)-right.sum).abs
    diff2 = (left.sum - (right.sum + currentWeight)).abs
    ((diff1 < diff2) ? left : right) << currentWeight
  end
  return [left,right,(left.sum-right.sum).abs]
end

=begin
items = [7, 9, 7, 6, 7, 7, 5, 7, 5, 6]
result = hillClimbing(items)
p result
=end
