require_relative 'exercise1.rb'
# Exercise 13

def quickSort3(array,from,to)
  if(from>=to) then return end
  divider=array[from]
  lo,hi=from,to
  while(true)
    while(array[hi]>=divider)
      hi-=1
      if(hi<=lo) then break end
    end
    if(hi<=lo)
      array[lo]=divider
      break
    end
    array[lo]=array[hi]
    lo=lo+1
    while(array[lo]<divider)
      lo+=1
      if(lo>=hi) then break end
    end
    if(lo>=hi)
      lo=hi
      array[hi]=divider
      break
    end
    array[hi]=array[lo]
  end
  quickSort3(array,from,lo-1)
  quickSort3(array,lo+1,to)
end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
quickSort3(arr,0,ARRAY_SIZE-1)
raise ERR unless(isSortedAsc(arr))
