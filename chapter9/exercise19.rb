# Exercise 19

def PermuteKofNwithDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    0.upto(items.size-1) do |i|
      selections[index] = i
      PermuteKofNwithDuplicates(index+1,selections,items,results)
    end
  end
end


def PermuteKofNwithoutDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    0.upto(items.size-1) do |i|
      used = false
      0.upto(index-1) do |j|
        if(selections[j] == i) then used = true end
      end
      if(!used)
        selections[index] = i
        PermuteKofNwithoutDuplicates(index+1,selections,items,results)
      end
    end
  end
end

# PERMUTATIONS
a = []
b = []
PermuteKofNwithDuplicates(0,Array.new(3,0),[4,5,6],b)
raise "Error" if b!= [[4, 4, 4], [4, 4, 5], [4, 4, 6],
                  [4, 5, 4], [4, 5, 5], [4, 5, 6],
                  [4, 6, 4], [4, 6, 5], [4, 6, 6],
                  [5, 4, 4], [5, 4, 5], [5, 4, 6],
                  [5, 5, 4], [5, 5, 5], [5, 5, 6],
                  [5, 6, 4], [5, 6, 5], [5, 6, 6],
                  [6, 4, 4], [6, 4, 5], [6, 4, 6],
                  [6, 5, 4], [6, 5, 5], [6, 5, 6],
                  [6, 6, 4], [6, 6, 5], [6, 6, 6]]

a = []
b = []
PermuteKofNwithoutDuplicates(0,Array.new(3,0),[4,5,6],b)
raise "Error" if b != [[4, 5, 6], [4, 6, 5],
                       [5, 4, 6], [5, 6, 4],
                       [6, 4, 5], [6, 5, 4]]
