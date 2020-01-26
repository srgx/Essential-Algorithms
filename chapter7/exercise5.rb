require_relative 'exercise1'
# Exercise 5

def binarySearchR(array,value,min,max)
  if(min>max) then return -1 end
  mid=(min+max)/2
  if(value<array[mid])
    binarySearchR(array,value,min,mid-1)
  elsif(value>array[mid])
    binarySearchR(array,value,min+1,max)
  else
    return mid
  end
end

M = NUMBERS.size - 1
raise ERR unless(binarySearchR(NUMBERS,2,0,M)==-1)
raise ERR unless(binarySearchR(NUMBERS,100,0,M)==-1)
raise ERR unless(binarySearchR(NUMBERS,44,0,M)==-1)
raise ERR unless(binarySearchR(NUMBERS,99,0,M)==4)
raise ERR unless(binarySearchR(NUMBERS,12,0,M)==0)
raise ERR unless(binarySearchR(NUMBERS,43,0,M)==2)
