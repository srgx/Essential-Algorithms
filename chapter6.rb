# Exercise 1

def swap(array,i1,i2)
  array[i1],array[i2]=array[i2],array[i1]
end

def someSort(array)
  0.upto(array.size-1) do |i|
    0.upto(i-1) do |j|
      if(array[j]>array[i])
        swap(array,i,j)
      end
    end
  end
end

def insertionSort(array)
  1.upto(array.size-1) do |i|
    v=array[i]
    j=i
    while(j>0&&array[j-1]>v)
      array[j]=array[j-1]
      j-=1
    end
    array[j]=v
  end
end

# Exercise 2
# List of size 1 is already sorted so algorithm can start with index 1
# Run time is O(N^2)


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

# Exercise 4
# Last element is in correct place so algorithm can end at index=size-2.
# Run time is O(N^2)

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

def isSortedAsc(array)
  sorted=true
  0.upto(array.size-2) do |i|
    if (array[i]>array[i+1])
      sorted=false
      break
    end
  end
  return sorted
end

def isSortedDesc(array)
  sorted=true
  0.upto(array.size-2) do |i|
    if (array[i]<array[i+1])
      sorted=false
      break
    end
  end
  return sorted
end


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


# Exercise 7

class HeapQueue # priority queue
  attr_reader :values, :priorities
  def initialize
    @array_size=10
    @next_index=0
    @values = Array.new(@array_size)
    @priorities = Array.new(@array_size)
  end

  def enqueue(value,priority)
    if(@next_index>=@array_size) then raise "Queue is full!" end
    @values[@next_index]=value
    @priorities[@next_index]=priority

    index=@next_index
    while(index!=0)
      parent=(index-1)/2
      
      if(@priorities[index]<=@priorities[parent]) then break end
      
      
      swap(@values,index,parent)
      
      swap(@priorities,index,parent)
      
      index=parent
    end
    @next_index+=1
  end
  
  def dequeue
    if(@next_index==0) then raise "Queue empty!" end
    result=@values[0]
    @values[0]=@values[@next_index-1]
    @priorities[0]=@priorities[@next_index-1]
    index=0
    while(true)
      child1=2*index+1
      child2=2*index+2
      
      if(child1 >= @next_index) then child1=index end
      if(child2 >= @next_index) then child2=index end
     
      if(@priorities[index]>=@priorities[child1]&&
         @priorities[index]>=@priorities[child2]) then break end
      
      swap_child = @priorities[child1]>@priorities[child2] ? child1 : child2
      
      swap(@values,index,swap_child)
      swap(@priorities,index,swap_child)
      
      index=swap_child
    end
    @next_index-=1
    return result
  end
end


queue=HeapQueue.new
queue.enqueue("cat",12)
queue.enqueue("tiger",80)
queue.enqueue("mouse",5)
queue.enqueue("dog",8)
queue.enqueue("lion",90)
queue.enqueue("dragon",120)
queue.enqueue("fox",70)



# Exercise 8
# Add O(log N), Remove O(log N)

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


ERR="Error"

sorted=["dragon","lion","tiger","fox","cat","dog","mouse"]
sorted.each do |a|
  if(queue.dequeue!=a) then raise ERR end
end


ARRAY_SIZE=4000

arr=[]
ARRAY_SIZE.times { arr << rand(100) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
selectionSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Selection sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end

arr=[]
ARRAY_SIZE.times { arr << rand(100) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
insertionSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Insertion sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end

arr=[]
ARRAY_SIZE.times { arr << rand(100) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
someSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Some sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end



arr=[]
ARRAY_SIZE.times { arr << rand(100) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
bubbleSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Bubble sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end
    

arr=[]
ARRAY_SIZE.times { arr << rand(100) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
betterBubbleSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Better bubble sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end


arr=[]
ARRAY_SIZE.times { arr << rand(100) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
heapSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Heap sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end


