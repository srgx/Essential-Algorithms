# Exercise 18

def SelectKofNwithDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    start = 0
    if(index>0) then start = selections[index-1] end
    start.upto(items.size-1) do |i|
      selections[index] = i
      SelectKofNwithDuplicates(index+1,selections,items,results)
    end
  end
end

def SelectKofNwithoutDuplicates(index,selections,items,results)
  if(index==selections.size)
    result = []
    0.upto(selections.size-1) do |i|
      result << items[selections[i]]
    end
    results << result
  else
    start = 0
    if(index>0) then start = selections[index-1] + 1 end
    start.upto(items.size-1) do |i|
      selections[index] = i
      SelectKofNwithoutDuplicates(index+1,selections,items,results)
    end
  end
end


# SELECTIONS
a = []
b = []
SelectKofNwithDuplicates(0,Array.new(2,0),[4,5,6],b)
raise "Error" if b!= [[4, 4], [4, 5], [4, 6], [5, 5], [5, 6], [6, 6]]

a = []
b = []
SelectKofNwithoutDuplicates(0,Array.new(2,0),[4,5,6],b)
raise "Error" if b!= [[4, 5], [4, 6], [5, 6]]
