require_relative 'exercise1.rb'
# Exercise 11

def quickSort(array,from,to)
  if(from>=to) then return end
  before,after=[],[] # stacks
  swap(array,from,rand(from..to))
  divider=array[from]
  (from+1).upto(to) do |i|
    v=array[i]
    if(v<divider)
      before.push(v)
    else
      after.push(v)
    end
  end

  i=from
  while((g=before.pop)!=nil)
    array[i]=g
    i+=1
  end
  array[i],mid=divider,i
  i+=1
  while((g=after.pop)!=nil)
    array[i]=g
    i+=1
  end
  quickSort(array,from,mid-1)
  quickSort(array,mid+1,to)
end

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
quickSort(arr,0,ARRAY_SIZE-1)
raise ERR unless(isSortedAsc(arr))
