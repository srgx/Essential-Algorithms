require_relative 'exercise1.rb'
# Exercise 9

def makeHeap(array)
  0.upto(array.size-1) do |i|
    index=i
    while(index!=0)
      parent=(index-1)/2
      if(array[index]<=array[parent]) then break end
      swap(array,index,parent)
      index=parent
    end
  end
end

def heapSort(array)
  makeHeap(array)
  currentSize=array.size
  (array.size-1).downto(0) do |i|
    swap(array,0,i)
    currentSize-=1
    index=0
    while(true)
      child1=2*index+1
      child2=2*index+2

      if(child1 >= currentSize) then child1=index end
      if(child2 >= currentSize) then child2=index end

      if(array[index]>=array[child1]&&
         array[index]>=array[child2]) then break end

      swap_child = array[child1]>array[child2] ? child1 : child2

      swap(array,index,swap_child)

      index=swap_child
    end
  end
end

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
heapSort(arr)
raise ERR unless(isSortedAsc(arr))
