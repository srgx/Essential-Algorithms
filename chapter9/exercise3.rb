# Exercise 3

def hanoi(from,to,helper,n,solution)
  if(n==1)
    solution << [from,to]
    puts "#{from} -> #{to}" # move one disc
  else
    hanoi(from,helper,to,n-1,solution) # move smaller discs to helper
    solution << [from,to]
    puts "#{from} -> #{to}" # move largest disc to destination
    hanoi(helper,to,from,n-1,solution) # move smaller disc to destination
    return solution
  end
end

# hanoi(0,2,1,3,[])
