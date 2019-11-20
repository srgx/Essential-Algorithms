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

# Exercise 4
exampleArray=[7,8,9,10]

def removeItem(arr,index)
  index.upto(arr.size-2) { | i | arr[i]=arr[i+1] }
  arr.pop # resize array
end


removeItem(exampleArray,1)
if(exampleArray!=[7,9,10]) then raise ERR end

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

def initializeArray(bounds)
  numDimensions=bounds.size/2
  sliceSizes=Array.new(numDimensions)
  lowerBounds=Array.new(numDimensions)
  slice_size=1
  (numDimensions-1).downto(0) do |i|
    sliceSizes[i]=slice_size
    lowerBounds[i]=bounds[2*i]
    upper_bound=bounds[2*i+1]
    bound_size=upper_bound=lowerBounds[i]+1
    slice_size*=bound_size
  end
end

if(findMedian([1,2,3])!=2) then raise ERR end



