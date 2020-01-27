# Exercise 1

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

def swap(array,i1,i2)
  array[i1],array[i2]=array[i2],array[i1]
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

def someSort(array)
  0.upto(array.size-1) do |i|
    0.upto(i-1) do |j|
      if(array[j]>array[i])
        swap(array,i,j)
      end
    end
  end
end

ERR="Error"
ARRAY_SIZE=1000
RAND_RANGE=ARRAY_SIZE*2

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
insertionSort(arr)
raise ERR unless(isSortedAsc(arr))

arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
someSort(arr)
raise ERR unless(isSortedAsc(arr))
