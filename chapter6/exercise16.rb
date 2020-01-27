# Exercise 16

def countingSort2(array,min_value,max_value) # counting sort with mapping

  size=max_value-min_value+1
  counts=Array.new(size)

  0.upto(size-1) { |i| counts[i] = 0 }
  0.upto(array.size-1) { |i| counts[array[i]-min_value]+=1 }

  index=0
  0.upto(size-1) do |i|
    counts[i].times do
      array[index]=i+min_value
      index+=1
    end
  end

end


RESULT=[200, 202, 202, 203, 204, 205, 210]
arr=[205,200,202,210,203,204,202]
countingSort2(arr,200,210)
if(arr!=RESULT) then raise ERR end
