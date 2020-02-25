require_relative 'exercise5.rb'
# Exercise 6

for i in 5..25
  items = []
  for j in 1..i
    items << j
  end
  res1 = startExhaustivePartition(items,true)
  res2 = startBranchAndBound(items,true)
  exh = res1[1]
  brn = res2[1]
  puts "----------------------------"
  puts "Number of items: #{i}"
  puts "Nodes exhaustive: #{exh}"
  puts "Nodes branch and bound: #{brn}"
  puts "----------------------------"
end
