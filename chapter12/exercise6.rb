require_relative 'exercise5.rb'
# Exercise 6

def graph(maxItems)
  items = [1,2,3,4]
  results = []

  for i in 5..maxItems
    items << i
    exhaustive = startExhaustivePartition(items,false)
    branchBound = startBranchAndBound(items,false)
    results << [exhaustive[1],branchBound[1],i]
  end


  puts "**Nodes**"
  puts "-" * 60

  results.each do |result|
    puts "Number of items: #{result[2]}"
    puts "Nodes exhaustive: #{result[0]}"
    puts "Nodes branch and bound: #{result[1]}"
    puts "-" * 60
  end

  puts "**Logarithms**"
  puts "-" * 60

  results.each do |result|
    puts "Log items: #{Math.log(result[2])}"
    puts "Log nodes exhaustive: #{Math.log(result[0])}"
    puts "Log nodes branch and bound: #{Math.log(result[1])}"
    puts "-" * 60
  end
end

# graph(10)
