require_relative 'exercise1.rb'
# Exercise 5

def bubbleSort(array)
  swp=true
  while(swp)
    swp=false
    0.upto(array.size-2) do |i|
      if(array[i]>array[i+1])
        swap(array,i,i+1)
        swp=true
      end
    end
  end
end

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
bubbleSort(arr)
raise ERR unless(isSortedAsc(arr))
