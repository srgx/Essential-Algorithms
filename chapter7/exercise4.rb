require_relative 'exercise1'
# Exercise 4

def binarySearch(array,value)
  min=0
  max=array.size-1
  while(min<=max)
    mid=(min+max)/2
    if(value<array[mid])
      max=mid-1
    elsif(value>array[mid])
      min=mid+1
    else
      return mid
    end
  end
  return -1
end

raise ERR unless(binarySearch(NUMBERS,2)==-1)
raise ERR unless(binarySearch(NUMBERS,100)==-1)
raise ERR unless(binarySearch(NUMBERS,44)==-1)
raise ERR unless(binarySearch(NUMBERS,99)==4)
raise ERR unless(binarySearch(NUMBERS,12)==0)
raise ERR unless(binarySearch(NUMBERS,43)==2)
