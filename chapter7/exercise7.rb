require_relative 'exercise5.rb'
# Exercise 7

def interpolationSearchR(array,value,min,max)
  if(min<=max)
    if(min==max||array[min]==array[max])
      return array[min]==value ? min : -1
    else
      mid=min+(max-min)*(value-array[min])/(array[max]-array[min])
      mid=mid<=min||mid>=max ? (min+max)/2 : mid
      if(value<array[mid])
        interpolationSearchR(array,value,min,mid-1)
      elsif(value>array[mid])
        interpolationSearchR(array,value,mid+1,max)
      else
        return mid
      end
    end
  else
    return -1
  end
end

raise ERR unless(interpolationSearchR(NUMBERS,2,0,M)==-1)
raise ERR unless(interpolationSearchR(NUMBERS,100,0,M)==-1)
raise ERR unless(interpolationSearchR(NUMBERS,44,0,M)==-1)
raise ERR unless(interpolationSearchR(NUMBERS,99,0,M)==4)
raise ERR unless(interpolationSearchR(NUMBERS,12,0,M)==0)
raise ERR unless(interpolationSearchR(NUMBERS,43,0,M)==2)
