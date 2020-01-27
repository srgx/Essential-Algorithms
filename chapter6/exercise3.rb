require_relative 'exercise1.rb'
# Exercise 3

def selectionSort(array)
  0.upto(array.size-1) do |i|
    min_indx=i
    (i+1).upto(array.size-1) do |j|
      if(array[j]<array[min_indx]) then min_indx=j end
    end
    swap(array,i,min_indx)
  end
end

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
selectionSort(arr)
raise ERR unless(isSortedAsc(arr))
