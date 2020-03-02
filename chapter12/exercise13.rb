require_relative 'exercise11.rb'
# Exercise 13

def randomSortedHillClimbing(low,up,size)
  items = []
  size.times { items << rand(low..up) }
  result = sortedHillClimbing(items)
  return result
end

=begin
result = randomSortedHillClimbing(1,100,10)
p result
=end
