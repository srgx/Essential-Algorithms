# Exercises 1,2
def sampleVariance(arr)
  avr=average(arr)
  s=0
  0.upto(arr.size-1) { |x| s+=(arr[x]-avr)**2 }
  return s/(arr.size-1)
end

def sampleStandardDeviation(arr)
  return Math.sqrt(sampleVariance(arr))
end

def average(arr)
  sum=0
  arr.each { |i| sum+=i }
  return sum/arr.size.to_f
end

ERR="Error"
SAMPLE1=[3,5,9,12]
SAMPLE2=[17,15,23,7,9,13]

if(sampleVariance(SAMPLE1)!=16.25) then raise ERR end
if(sampleVariance(SAMPLE2)!=33.2) then raise ERR end


# Exercise 3
def findMedianSorted(arr)
  s=arr.size
  m=s/2
  if(s%2!=0)
    return arr[m]
  else
    return (arr[m]+arr[m-1])/2.0
  end
end

if(findMedianSorted([1,2,3])!=2) then raise ERR end
if(findMedianSorted([1,8,12,45,69])!=12) then raise ERR end
if(findMedianSorted([1,2,3,4,9,12,15])!=4) then raise ERR end
if(findMedianSorted([12,33,98,131])!=65.5) then raise ERR end

# Exercise 4
exampleArray=[7,8,9,10]

def removeItem(arr,index)
  index.upto(arr.size-2) { | i | arr[i]=arr[i+1] }
  arr.pop # resize array
end


removeItem(exampleArray,1)
if(exampleArray!=[7,9,10]) then raise ERR end

# Exercise 5

def sum_to(x)
  (x**2+x)/2
end

# lower triangular array
def findIndex(r,c) # row, column
  cells_from_rows=sum_to(r)
  return cells_from_rows+c
end

# upper triangular array
def findIndex2(r,c,s) # row, column, size
  cells_from_rows=sum_to(s)-sum_to(s-r)
  return cells_from_rows+(c-r)
end

if(findIndex(3,2)!=8) then raise ERR end
if(findIndex(4,3)!=13) then raise ERR end
if(findIndex2(0,2,5)!=2) then raise ERR end
if(findIndex2(1,2,5)!=6) then raise ERR end
if(findIndex2(2,3,5)!=10) then raise ERR end
if(findIndex2(3,3,5)!=12) then raise ERR end
if(findIndex2(4,4,5)!=14) then raise ERR end


# Exercise 9
rectangularArray=[]
8.times { rectangularArray << Array.new(8) }

def findMin(arr)
  min=arr[0]
  1.upto(arr.size-1) do |i|
    if(arr[i]<min) then min=arr[i] end
  end
  return min
end

# Distance to the nearest edge
def distances(arr)
  h,w=arr.size,arr[0].size
  0.upto(arr.size-1) do |i| # rows
    0.upto(arr[i].size-1) do |j| # cols
      arr[i][j]=findMin([i,j,h-(i+1),w-(j+1)]) # from top, left, bottom, right
    end
  end
end

def showArray(arr)
  arr.each { |r| p r }
end

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


