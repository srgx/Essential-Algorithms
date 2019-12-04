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

# Exercise 11
def quickSort(array,from,to)
  if(from>=to) then return end
  before,after=[],[] # stacks
  swap(array,from,rand(from..to))
  divider=array[from]
  (from+1).upto(to) do |i|
    v=array[i]
    if(v<divider)
      before.push(v)
    else
      after.push(v)
    end
  end
  
  i=from
  while((g=before.pop)!=nil)
    array[i]=g
    i+=1
  end
  array[i],mid=divider,i
  i+=1
  while((g=after.pop)!=nil)
    array[i]=g
    i+=1
  end
  quickSort(array,from,mid-1)
  quickSort(array,mid+1,to)
end

# Exercise 12
def quickSort2(array,from,to)
  if(from>=to) then return end
  before,after=[],[] # queues
  swap(array,from,rand(from..to))
  divider=array[from]
  (from+1).upto(to) do |i|
    v=array[i]
    if(v<divider)
      before.push(v)
    else
      after.push(v)
    end
  end
  
  i=from
  while((g=before.shift)!=nil)
    array[i]=g
    i+=1
  end
  array[i],mid=divider,i
  i+=1
  while((g=after.shift)!=nil)
    array[i]=g
    i+=1
  end
  quickSort2(array,from,mid-1)
  quickSort2(array,mid+1,to)
end

# Exercise 13
def quickSort3(array,from,to)
  if(from>=to) then return end
  divider=array[from]
  lo,hi=from,to
  while(true)
    while(array[hi]>=divider)
      hi-=1
      if(hi<=lo) then break end
    end
    if(hi<=lo)
      array[lo]=divider
      break
    end
    array[lo]=array[hi]
    lo=lo+1
    while(array[lo]<divider)
      lo+=1
      if(lo>=hi) then break end
    end
    if(lo>=hi)
      lo=hi
      array[hi]=divider
      break
    end
    array[hi]=array[lo]
  end
  quickSort3(array,from,lo-1)
  quickSort3(array,lo+1,to)
end

# Exercise 14
# Divide elements into 3 parts, n<divider, n==divider, n>divider
# Don't sort middle group

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


# Exercises 10,17,19
# ...

# Exercise 18
def bucketSort(array,max_value,number_of_buckets)

  size=array.size
  buckets=Array.new(number_of_buckets)
  0.upto(number_of_buckets-1) { |i| buckets[i]=Array.new }
  bucket_width=(max_value+1)/number_of_buckets.to_f
  
  0.upto(array.size-1) do |i|
    value,index=array[i]
    index=(value/bucket_width).to_i
    buckets[index] << value
  end
  
  index=0
  buckets.each do |bkt|
    quickSort3(bkt,0,bkt.size-1)
    0.upto(bkt.size-1) do |i|
      array[index] = bkt[i]
      index+=1
    end
  end
  
end


ERR="Error"

# -----------------------------------------------------------------------------------------
RESULT=[200, 202, 202, 203, 204, 205, 210]
arr=[205,200,202,210,203,204,202]
countingSort2(arr,200,210)
if(arr!=RESULT) then raise ERR end
# -----------------------------------------------------------------------------------------
sorted=["dragon","lion","tiger","fox","cat","dog","mouse"]
sorted.each do |a|
  if(queue.dequeue!=a) then raise ERR end
end
# -----------------------------------------------------------------------------------------
ARRAY_SIZE=2000
RAND_RANGE=ARRAY_SIZE*2


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
selectionSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Selection sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
insertionSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Insertion sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
someSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Some sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end



arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
bubbleSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Bubble sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end
    

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
betterBubbleSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Better bubble sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
heapSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Heap sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end



arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
quickSort(arr,0,arr.size-1)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Quick sort with stacks - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
quickSort2(arr,0,arr.size-1)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Quick sort with queues - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
quickSort3(arr,0,arr.size-1)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Quick sort in place - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
countingSort(arr,RAND_RANGE)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Counting sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
starting= Process.clock_gettime(Process::CLOCK_MONOTONIC)
bucketSort(arr,RAND_RANGE,RAND_RANGE/10) # values per bucket
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Bucket sort - #{elapsed}"

unless(isSortedAsc(arr)) then raise ERR end




