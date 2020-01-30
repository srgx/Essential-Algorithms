
# --------------------------------------------------------------------------
# --------------------------------------------------------------------------
# O(N^2) example
def findMedian(arr)
  0.upto(arr.size-1) do |i|
    num_larger=0
    num_smaller=0
    0.upto(arr.size-1) do |j|
      if (arr[j]<arr[i]) then num_smaller+=1 end
      if (arr[j]>arr[i]) then num_larger+=1 end
    end
    if(num_smaller==num_larger) then return arr[i] end
  end
end

def arraySize(lower_bounds,upper_bounds)
  total_size=1 # 0 in book(error?)
  0.upto(lower_bounds.size-1)do |i|
    total_size*=(upper_bounds[i]-lower_bounds[i])
  end
  return total_size
end

if(arraySize([1,2,4,6],[3,5,7,9])!=54) then raise ERR end # 2*3*3*3

# bounds array holds alternating lower and upper bounds
def initializeArray(bounds)
  numDimensions=bounds.size/2
  sliceSizes=Array.new(numDimensions)
  lowerBounds=Array.new(numDimensions)
  slice_size=1
  (numDimensions-1).downto(0) do |i| # start from 1/2 array
    sliceSizes[i]=slice_size
    lowerBounds[i]=bounds[2*i]
    upper_bound=bounds[2*i+1]
    bound_size=upper_bound-lowerBounds[i]+1 # size of current dimension, 2 2 3
    slice_size*=bound_size # 1*2 -> 2*2 -> 4*3
  end
  # lowerBounds -> [0,4,9]
  # sliceSizes -> [4,2,1] (2x2 slice, row of length 2, cell)
  return Array.new(slice_size) # sliceSize -> 12
end

if(findMedian([1,2,3])!=2) then raise ERR end


if(initializeArray([0,2,0,2]).size!=9) then raise ERR end # 3*3
if(initializeArray([4,6,0,3]).size!=12) then raise ERR end # 3*4

# example for algorithm comments
EXAMPLE=[0,2,4,5,9,10]
if(initializeArray(EXAMPLE).size!=12) then raise ERR end # 3 2 2


# hmmm
def mapIndicesToIndex(indices,lowerBounds,sliceSizes)
  index=0
  0.upto(indices.size-1) do |i|
    index=index+(indices[i]-lowerBounds[i])*sliceSizes[i]
  end
  return index
end

lb=[0,4,9] # lower bounds
sls=[4,2,1] # slice sizes

if(mapIndicesToIndex([0,4,9],lb,sls)!=0) then raise ERR end # first index
if(mapIndicesToIndex([1,4,9],lb,sls)!=4) then raise ERR end
if(mapIndicesToIndex([2,4,9],lb,sls)!=8) then raise ERR end
if(mapIndicesToIndex([2,5,10],lb,sls)!=11) then raise ERR end # last index for size 12


def indicesExample
  0.upto(2) do |i|
    4.upto(5) do |j|
      9.upto(10) do |k|
        index=mapIndicesToIndex([i,j,k],[0,4,9],[4,2,1])
        puts "#{i},#{j},#{k} -> #{index}"
      end
    end
  end
end

=begin
indicesExample

0,4,9 -> 0
0,4,10 -> 1
0,5,9 -> 2
0,5,10 -> 3
1,4,9 -> 4
1,4,10 -> 5
1,5,9 -> 6
1,5,10 -> 7
2,4,9 -> 8
2,4,10 -> 9
2,5,9 -> 10
2,5,10 -> 11

=end
