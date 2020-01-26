require_relative 'exercise1'
# Exercise 6

def interpolationSearch(array,value)
  min,max=0,array.size-1
  while(min<=max)
    if(min==max||array[min]==array[max])
      if(array[min]==value) then return min else break end
    else
      mid=min+(max-min)*(value-array[min])/(array[max]-array[min])
      mid=mid<=min||mid>=max ? (min+max)/2 : mid
      if(value<array[mid])
        max=mid-1
      elsif(value>array[mid])
        min=mid+1
      else
        return mid
      end
    end
  end
  return -1
end

raise ERR unless(interpolationSearch(NUMBERS,2)==-1)
raise ERR unless(interpolationSearch(NUMBERS,100)==-1)
raise ERR unless(interpolationSearch(NUMBERS,44)==-1)
raise ERR unless(interpolationSearch(NUMBERS,99)==4)
raise ERR unless(interpolationSearch(NUMBERS,12)==0)
raise ERR unless(interpolationSearch(NUMBERS,43)==2)
