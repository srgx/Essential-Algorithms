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
    j=i-1
    while(j>=0&&array[j]>v)
      array[j+1]=array[j]
      j-=1
    end
    array[j+1]=v
  end
end

arr=[]
5000.times { arr << rand(100) }

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
insertionSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts elapsed


arr=[]
5000.times { arr << rand(100) }

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
someSort(arr)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts elapsed

arr=[6,3,5,4,5,2,1]
someSort(arr)
p arr


