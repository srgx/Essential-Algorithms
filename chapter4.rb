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

# Exercises 5, 6

def sum_to(x)
  (x**2+x)/2
end

# lower left triangular array
def findIndex(r,c) # row, column
  cells_from_rows=sum_to(r)
  return cells_from_rows+c
end

# upper right triangular array (map rows in order)
def findIndex2(r,c,s) # row, column, size
  cells_from_rows=sum_to(s)-sum_to(s-r)
  return cells_from_rows+(c-r)
end

# upper right triangular array with different mapping (columns from findIndex are rows)
def findIndex3(r,c)
  return findIndex(c,r)
end

# upper left triangular array (rows from findIndex in reverse order)
# (r+c)<s
def findIndex4(r,c,s)
  findIndex(s-(r+1),c)
end


if(findIndex(3,2)!=8) then raise ERR end
if(findIndex(4,3)!=13) then raise ERR end
if(findIndex2(0,2,5)!=2) then raise ERR end
if(findIndex2(1,2,5)!=6) then raise ERR end
if(findIndex2(2,3,5)!=10) then raise ERR end
if(findIndex2(3,3,5)!=12) then raise ERR end
if(findIndex2(4,4,5)!=14) then raise ERR end
if(findIndex3(0,2)!=3) then raise ERR end
if(findIndex3(1,3)!=7) then raise ERR end
if(findIndex4(0,2,5)!=12) then raise ERR end
if(findIndex4(2,1,5)!=4) then raise ERR end
if(findIndex4(3,1,5)!=2) then raise ERR end
if(findIndex4(4,0,5)!=0) then raise ERR end


# Exercises 7, 8
def showArray(arr)
  arr.each { |r| p r }
end

EMPTY_ARR=[]
8.times { EMPTY_ARR << Array.new(6) }

# main diagonal(on or below 1, above 0)
def fillArr(arr)
  0.upto(arr.size-1) do |i|
    0.upto(arr[0].size-1) do |j|
      arr[i][j] = (i>=j) ? 1 : 0
    end
  end
end

# antidiagonal(on or below 0, above 1)
def fillArr2(arr)
  width=arr[0].size
  0.upto(arr.size-1) do |i|
    0.upto(arr[0].size-1) do |j|
      arr[i][j] = (j+i<width) ? 1 : 0
    end
  end
end

=begin
fillArr(EMPTY_ARR)
showArray(EMPTY_ARR)
puts "-------------------"
fillArr2(EMPTY_ARR)
showArray(EMPTY_ARR)
=end

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

# Exercise 10
# j<=i, k<=j

# 0 0 0 - 0
# 1 0 0 - 1
# 1 1 0 - 2
# 1 1 1 - 3
# 2 0 0 - 4
# 2 1 0 - 5
# 2 1 1 - 6
# 2 2 0 - 7
# 2 2 1 - 8
# 2 2 2 - 9

def tetrahedral(rows)
  return (rows**3+3*(rows**2)+2*rows)/6
end


def findIndexT(x,y,z)
  return tetrahedral(x)+sum_to(y)+z
end

indexT=0
0.upto(3) do |i|
  0.upto(i) do |j|
    0.upto(j) do |k|
      if(findIndexT(i,j,k)!=indexT) then raise ERR end
      indexT+=1
    end
  end
end



# Exercise 11
# Check if col<=row

# Exercise 12

# triangular arrays(3x3)
TR_1=[1,2,3,4,5,6]
TR_2=[7,8,9,10,11,12]

def addTriangular(arr1,arr2,s)
  new_arr=Array.new(arr1.size)
  0.upto(s-1) do |i|
    0.upto(i) do |j|
      index=findIndex(i,j)
      new_arr[index]=arr1[index]+arr2[index]
    end
  end
  return new_arr
end

TR_SUM=[8, 10, 12, 14, 16, 18]

if(addTriangular(TR_1,TR_2,3)!=TR_SUM) then raise ERR end


# Exercise 13

MATRIX1=[[1,2,3],
         [4,5,6],
         [8,2,55]]
MATRIX2=[[7,8,9],
         [12,1,33],
         [5,6,2]]

RESULT=[[0,0,0],[0,0,0],[0,0,0]]


def multiplyArrays(arr1,arr2,result)
  0.upto(arr1.size-1) do |i|
    0.upto(arr1[0].size-1) do |j|
      result[i][j]=0
      0.upto(arr1[0].size-1) do |k|
        result[i][j]+=(arr1[i][k]*arr2[k][j])
      end
    end
  end
end

multiplyArrays(MATRIX1,MATRIX2,RESULT)

if(RESULT!=[[46, 28, 81], [118, 73, 213], [355, 396, 248]]) then raise ERR end


TR_3=[4,
      2,7,
      3,5,9]
TR_4=[7,
      6,8,
      2,6,2]

def showTriangular(arr)
  c=row=1
  0.upto(arr.size-1) do |i|
    print "[#{arr[i]}]"
    c-=1
    if(c==0)
      row+=1
      c=row
      puts
    end
  end
end


def multiplyTriangular(arr1,arr2,s)
  new_arr=Array.new(arr1.size)
  0.upto(s-1) do |i|
    0.upto(s-1) do |j|
      new_arr[findIndex(i,j)]=0
      0.upto(s-1) do |k|
        if(k<=i&&k>=j)
          new_arr[findIndex(i,j)]+=arr1[findIndex(i,k)]*arr2[findIndex(k,j)]
        end
      end
    end
  end
  return new_arr
end

if(multiplyTriangular(TR_3,TR_4,3)!=[28,56,56,69,94,18]) then raise ERR end

# Exercise 14
class ArrayRow
  attr_accessor :row_number, :next_row, :row_sentinel
end

class ArrayEntry
  attr_accessor :column_number, :value, :next_entry
end

def findRowBefore(row,array_row_sentinel)
  array_row=array_row_sentinel
  while(array_row.next_row!=nil&&array_row.next_row.row_number<row)
    array_row=array_row.next_row
  end
  return array_row
end

def findColumnBefore(column,row_sentinel)
  array_entry=row_sentinel
  while(array_entry.next_entry!=nil&&array_entry.next_entry.column_number<column)
    array_entry=array_entry.next_entry
  end
  return array_entry
end

def getValue(row,column,sentinel)
  default=0
  array_row=findRowBefore(row,sentinel)
  array_row=array_row.next_row
  if(array_row.nil?||array_row.row_number>row) then return default end
  array_entry=findColumnBefore(column,array_row.row_sentinel)
  array_entry=array_entry.next_entry
  if(array_entry.nil?||array_entry.column_number>column) then return default end
  return array_entry.value
end

def setValue(row,column,value,sentinel)
  default=0
  if(value==default)
    deleteEntry(row,column,sentinel)
    return
  end
  
  array_row=findRowBefore(row,sentinel)
  if(array_row.next_row.nil?||array_row.next_row.row_number>row)
    new_row=ArrayRow.new
    new_row.row_number=row
    new_row.next_row=array_row.next_row
    array_row.next_row=new_row
    sentinel_entry=ArrayEntry.new
    new_row.row_sentinel=sentinel_entry
    sentinel_entry.next_entry=nil
  end
  array_row=array_row.next_row
  
  array_entry=findColumnBefore(column,array_row.row_sentinel)
  if(array_entry.next_entry.nil?||array_entry.next_entry.column_number>column)
    new_entry=ArrayEntry.new
    new_entry.column_number=column
    new_entry.next_entry=array_entry.next_entry
    array_entry.next_entry=new_entry
  end
  array_entry=array_entry.next_entry
  array_entry.value=value
end

def deleteEntry(row,column,sentinel)
  array_row=findRowBefore(row,sentinel)
  if(array_row.next_row.nil?||array_row.next_row.row_number>row) then return end
  target_row=array_row.next_row
  array_entry=findColumnBefore(column,target_row.row_sentinel)
  if(array_entry.next_entry.nil?||array_entry.next_entry.column_number>column) then return end
  array_entry.next_entry=array_entry.next_entry.next_entry
  if(target_row.row_sentinel.next_entry.nil?)
    array_row.next_row=array_row.next_row.next_row
  end
end

def showSparseRows(sentinel)
  while(sentinel.next_row!=nil)
    puts sentinel.next_row.row_number
    sentinel=sentinel.next_row
  end
end

# copy row to result
def copyEntries(row,result)
  sentinel=row.row_sentinel
  r=row.row_number
  while(sentinel.next_entry!=nil)
    c=sentinel.next_entry.column_number
    v=sentinel.next_entry.value
    setValue(r,c,v,result)
    sentinel=sentinel.next_entry
  end
end

# add sum of rows to result
def addEntries(row1,row2,result)
  r=row1.row_number
  s1=row1.row_sentinel
  s2=row2.row_sentinel
  
  while(s1.next_entry!=nil&&s2.next_entry!=nil)
    if(s1.next_entry.column_number==s2.next_entry.column_number)
      sum=s1.next_entry.value+s2.next_entry.value
      c=s1.next_entry.column_number
      setValue(r,c,sum,result)
      s1=s1.next_entry
      s2=s2.next_entry
    elsif(s1.next_entry.column_number<s2.next_entry.column_number)
      setValue(r,s1.next_entry.column_number,s1.next_entry.value,result)
      s1=s1.next_entry
    else
      setValue(r,s2.next_entry.column_number,s2.next_entry.value,result)
      s2=s2.next_entry
    end
  end
  
  while(s1.next_entry!=nil)
    setValue(r,s1.next_entry.column_number,s1.next_entry.value,result)
    s1=s1.next_entry
  end
  while(s2.next_entry!=nil)
    setValue(r,s2.next_entry.column_number,s2.next_entry.value,result)
    s2=s2.next_entry
  end
  
end

# add sparse arrays
def addArrays(arr1,arr2,result)
  arr1_row=arr1.next_row
  arr2_row=arr2.next_row
  result_row=result.next_row
  
  while(arr1_row!=nil&&arr2_row!=nil)
    if(arr1_row.row_number<arr2_row.row_number)
      copyEntries(arr1_row,result)
      arr1_row=arr1_row.next_row
    elsif(arr2_row.row_number<arr1_row.row_number)
      copyEntries(arr2_row,result)
      arr2_row=arr2_row.next_row
    else
      addEntries(arr1_row,arr2_row,result)
      arr1_row=arr1_row.next_row
      arr2_row=arr2_row.next_row
    end
  end
  
  while(arr1_row!=nil)
    copyEntries(arr1_row,result)
    arr1_row=arr1_row.next_row
  end
  while(arr2_row!=nil)
    copyEntries(arr2_row,result)
    arr2_row=arr2_row.next_row
  end
  
end

sparseSentinel=ArrayRow.new
setValue(0,0,5,sparseSentinel)
setValue(0,1,5,sparseSentinel)
setValue(0,3,5,sparseSentinel)
setValue(0,5,5,sparseSentinel)
sparseSentinel2=ArrayRow.new
0.upto(7) { |i| setValue(0,i,5,sparseSentinel2) }
1.upto(4) { |i| setValue(i,2,8,sparseSentinel2) }


sparseResult=ArrayRow.new
addArrays(sparseSentinel,sparseSentinel2,sparseResult)
if(getValue(0,3,sparseResult)!=10) then raise ERR end
if(getValue(0,4,sparseResult)!=5) then raise ERR end
if(getValue(1,2,sparseResult)!=8) then raise ERR end
if(getValue(0,6,sparseResult)!=5) then raise ERR end
if(getValue(0,7,sparseResult)!=5) then raise ERR end
2.upto(4) { |i| if(getValue(i,2,sparseResult)!=8) then raise ERR end }


# Exercise 15
MT1=ArrayRow.new
MT2=ArrayRow.new

=begin
MATRIX1=[[1,2],
         [4,5]]
MATRIX2=[[7,8],
         [12,1]]
=end

# MT1 and MT2 are MATRIX1 and MATRIX2 sparse arrays


setValue(0,0,1,MT1)
setValue(0,1,2,MT1)
setValue(1,0,4,MT1)
setValue(1,1,5,MT1)

setValue(0,0,7,MT2)
setValue(0,1,8,MT2)
setValue(1,0,12,MT2)
setValue(1,1,1,MT2)


def multiplySparseArrays(arr1,arr2,result,s)
  0.upto(s-1) do |i|
    0.upto(s-1) do |j|
      setValue(i,j,0,result)
      0.upto(s-1) do |k|
        current_result=getValue(i,j,result)
        arr1_value=getValue(i,k,arr1)
        arr2_value=getValue(k,j,arr2)
        setValue(i,j,current_result+(arr1_value*arr2_value),result)
      end
    end
  end
end

def multiplySparseMatrices(arr1,arr2,result)
  new_array2=ArrayRow.new
  arr2_row=arr2.next_row
  while(arr2_row!=nil)
    r=arr2_row.row_number
    sentinel=arr2_row.row_sentinel
    while(sentinel.next_entry!=nil)
      setValue(sentinel.next_entry.column_number,r,sentinel.next_entry.value,new_array2)
      sentinel=sentinel.next_entry
    end
    arr2_row=arr2_row.next_row
  end
  
  arr1_row=arr1.next_row
  while(arr1_row!=nil)
    arr2_row=new_array2.next_row # first column
    while(arr2_row!=nil)
      total=0
      arr1_cell=arr1_row.row_sentinel.next_entry
      arr2_cell=arr2_row.row_sentinel.next_entry
      while(arr1_cell!=nil&&arr2_cell!=nil)
        if(arr1_cell.column_number==arr2_cell.column_number)
          total+=arr1_cell.value*arr2_cell.value
          arr1_cell=arr1_cell.next_entry
          arr2_cell=arr2_cell.next_entry
        elsif(arr1_cell.column_number<arr2_cell.column_number)
          arr1_cell=arr1_cell.next_entry
        else
          arr2_cell=arr2_cell.next_entry
        end
      end
      setValue(arr1_row.row_number,arr2_row.row_number,total,result)
      arr2_row=arr2_row.next_row # next column
    end
    arr1_row=arr1_row.next_row
  end
  
end

def test1(res)
  if(getValue(0,0,res)!=31||
     getValue(0,1,res)!=10) then raise ERR end

  if(getValue(1,0,res)!=88||
     getValue(1,1,res)!=37) then raise ERR end
end

def test2(res)
  if(getValue(0,0,res)!=24||
     getValue(1,0,res)!=0||
     getValue(2,0,res)!=12||
     getValue(0,1,res)!=8||
     getValue(1,1,res)!=0||
     getValue(2,1,res)!=13||
     getValue(0,2,res)!=572||
     getValue(1,2,res)!=176||
     getValue(2,2,res)!=220) then raise ERR end
end


sparseMulRes=ArrayRow.new
multiplySparseArrays(MT1,MT2,sparseMulRes,2)
test1(sparseMulRes)

sparseMulRes=ArrayRow.new
multiplySparseMatrices(MT1,MT2,sparseMulRes)
test1(sparseMulRes)




DIFF1=ArrayRow.new
DIFF2=ArrayRow.new

setValue(0,0,12,DIFF1)
setValue(0,1,4,DIFF1)
setValue(1,0,8,DIFF1)
setValue(2,0,3,DIFF1)
setValue(2,1,2,DIFF1)
setValue(2,2,1,DIFF1)

setValue(0,2,22,DIFF2)
setValue(1,0,6,DIFF2)
setValue(1,1,2,DIFF2)
setValue(1,2,77,DIFF2)
setValue(2,1,9,DIFF2)

sparseMulRes=ArrayRow.new
multiplySparseMatrices(DIFF1,DIFF2,sparseMulRes)
test2(sparseMulRes)


sparseMulRes=ArrayRow.new
multiplySparseArrays(DIFF1,DIFF2,sparseMulRes,3)
test2(sparseMulRes)
 
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


