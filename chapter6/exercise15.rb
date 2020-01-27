require_relative 'exercise1.rb'
# Exercise 15

def countingSort(array,max_value)
  counts=Array.new(max_value+1)
  0.upto(max_value) { |i| counts[i] = 0 }
  0.upto(array.size-1) { |i| counts[array[i]]+=1 }

  index=0
  0.upto(max_value) do |i|
    counts[i].times do
      array[index]=i
      index+=1
    end
  end
end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
countingSort(arr,RAND_RANGE-1)
raise ERR unless(isSortedAsc(arr))
