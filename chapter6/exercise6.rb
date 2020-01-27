require_relative 'exercise1.rb'
# Exercise 6

def betterBubbleSort(array)
  swp=true
  from,to=0,array.size-2
  step=1
  direction=:up
  while(swp)
    swp=false
    i=from
    if(direction==:up)
      while(i<=to)
        if(array[i]>array[i+1])
          swap(array,i,i+1)
          swp=true
          last=i
        end
        i+=step
      end
    else
      while(i>=to)
        if(array[i]>array[i+1])
          swap(array,i,i+1)
          swp=true
          last=i
        end
        i+=step
      end
    end
    from,to=to,from
    from=last
    step*=-1
    direction = direction==:up ? :down : :up
  end
end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
betterBubbleSort(arr)
raise ERR unless(isSortedAsc(arr))
