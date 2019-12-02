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


ERR="Error"


ARRAY_SIZE=2000

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


