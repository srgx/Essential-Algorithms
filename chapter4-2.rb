# Exercises 14, 15

class ArrayRow
  attr_accessor :row_number, :next_row, :row_sentinel
end

class ArrayEntry
  attr_accessor :column_number, :value, :next_entry
end

class SparseArray
  attr_reader :sentinel

  def initialize
    @sentinel = ArrayRow.new
  end

  def findRowBefore(row)
    array_row=@sentinel
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

  def getValue(row,column)
    default=0
    array_row=findRowBefore(row)
    array_row=array_row.next_row
    if(array_row.nil?||array_row.row_number>row) then return default end
    array_entry=findColumnBefore(column,array_row.row_sentinel)
    array_entry=array_entry.next_entry
    if(array_entry.nil?||array_entry.column_number>column) then return default end
    return array_entry.value
  end

  def setValue(row,column,value)
    default=0
    if(value==default)
      deleteEntry(row,column)
      return
    end

    array_row=findRowBefore(row)
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

  def deleteEntry(row,column)
    array_row=findRowBefore(row)
    if(array_row.next_row.nil?||array_row.next_row.row_number>row) then return end
    target_row=array_row.next_row
    array_entry=findColumnBefore(column,target_row.row_sentinel)
    if(array_entry.next_entry.nil?||array_entry.next_entry.column_number>column) then return end
    array_entry.next_entry=array_entry.next_entry.next_entry
    if(target_row.row_sentinel.next_entry.nil?)
      array_row.next_row=array_row.next_row.next_row
    end
  end

  def +(other)
    result = SparseArray.new
    arr1_row=@sentinel.next_row
    arr2_row=other.sentinel.next_row
    result_row=result.sentinel.next_row

    while(arr1_row!=nil&&arr2_row!=nil)
      if(arr1_row.row_number<arr2_row.row_number)
        result.copyEntries(arr1_row)
        arr1_row=arr1_row.next_row
      elsif(arr2_row.row_number<arr1_row.row_number)
        result.copyEntries(arr2_row)
        arr2_row=arr2_row.next_row
      else
        result.addEntries(arr1_row,arr2_row)
        arr1_row=arr1_row.next_row
        arr2_row=arr2_row.next_row
      end
    end

    while(arr1_row!=nil)
      result.copyEntries(arr1_row)
      arr1_row=arr1_row.next_row
    end
    while(arr2_row!=nil)
      result.copyEntries(arr2_row)
      arr2_row=arr2_row.next_row
    end
    return result
  end

  def *(arr2)
    result = SparseArray.new
    new_array2=SparseArray.new
    arr2_row=arr2.sentinel.next_row
    while(arr2_row!=nil)
      r=arr2_row.row_number
      sentinel=arr2_row.row_sentinel
      while(sentinel.next_entry!=nil)
        new_array2.setValue(sentinel.next_entry.column_number,r,sentinel.next_entry.value)
        sentinel=sentinel.next_entry
      end
      arr2_row=arr2_row.next_row
    end

    arr1_row=@sentinel.next_row
    while(arr1_row!=nil)
      arr2_row=new_array2.sentinel.next_row # first column
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
        result.setValue(arr1_row.row_number,arr2_row.row_number,total)
        arr2_row=arr2_row.next_row # next column
      end
      arr1_row=arr1_row.next_row
    end
    return result
  end

  def addEntries(row1,row2)
    r=row1.row_number
    s1=row1.row_sentinel
    s2=row2.row_sentinel

    while(s1.next_entry!=nil&&s2.next_entry!=nil)
      if(s1.next_entry.column_number==s2.next_entry.column_number)
        sum=s1.next_entry.value+s2.next_entry.value
        c=s1.next_entry.column_number
        self.setValue(r,c,sum)
        s1=s1.next_entry
        s2=s2.next_entry
      elsif(s1.next_entry.column_number<s2.next_entry.column_number)
        self.setValue(r,s1.next_entry.column_number,s1.next_entry.value)
        s1=s1.next_entry
      else
        self.setValue(r,s2.next_entry.column_number,s2.next_entry.value)
        s2=s2.next_entry
      end
    end

    while(s1.next_entry!=nil)
      self.setValue(r,s1.next_entry.column_number,s1.next_entry.value)
      s1=s1.next_entry
    end
    while(s2.next_entry!=nil)
      self.setValue(r,s2.next_entry.column_number,s2.next_entry.value)
      s2=s2.next_entry
    end
  end

  def copyEntries(row)
    sentinel=row.row_sentinel
    r=row.row_number
    while(sentinel.next_entry!=nil)
      c=sentinel.next_entry.column_number
      v=sentinel.next_entry.value
      self.setValue(r,c,v)
      sentinel=sentinel.next_entry
    end
  end

  def showRows
    sentinel = @sentinel
    while(sentinel.next_row!=nil)
      puts sentinel.next_row.row_number
      sentinel=sentinel.next_row
    end
  end
end

ERR = "Error"

spar1 = SparseArray.new
spar2 = SparseArray.new

spar1.setValue(0,0,5)
spar1.setValue(0,3,5)
spar1.setValue(0,5,5)

0.upto(7) { |i| spar2.setValue(0,i,5) }
1.upto(4) { |i| spar2.setValue(i,2,8) }

sparres = spar1 + spar2

if(sparres.getValue(0,3)!=10) then raise ERR end
if(sparres.getValue(0,4)!=5) then raise ERR end
if(sparres.getValue(1,2)!=8) then raise ERR end
if(sparres.getValue(0,6)!=5) then raise ERR end
if(sparres.getValue(0,7)!=5) then raise ERR end
2.upto(4) { |i| if(sparres.getValue(i,2)!=8) then raise ERR end }

mt1=SparseArray.new
mt2=SparseArray.new

mt1.setValue(0,0,1)
mt1.setValue(0,1,2)
mt1.setValue(1,0,4)
mt1.setValue(1,1,5)

mt2.setValue(0,0,7)
mt2.setValue(0,1,8)
mt2.setValue(1,0,12)
mt2.setValue(1,1,1)

res=SparseArray.new
res = mt1 * mt2

if(res.getValue(0,0)!=31||
   res.getValue(0,1)!=10) then raise ERR end

if(res.getValue(1,0)!=88||
   res.getValue(1,1)!=37) then raise ERR end

d1=SparseArray.new
d2=SparseArray.new

d1.setValue(0,0,12)
d1.setValue(0,1,4)
d1.setValue(1,0,8)
d1.setValue(2,0,3)
d1.setValue(2,1,2)
d1.setValue(2,2,1)

d2.setValue(0,2,22)
d2.setValue(1,0,6)
d2.setValue(1,1,2)
d2.setValue(1,2,77)
d2.setValue(2,1,9)

res = d1 * d2
if(res.getValue(0,0)!=24||
   res.getValue(1,0)!=0||
   res.getValue(2,0)!=12||
   res.getValue(0,1)!=8||
   res.getValue(1,1)!=0||
   res.getValue(2,1)!=13||
   res.getValue(0,2)!=572||
   res.getValue(1,2)!=176||
   res.getValue(2,2,)!=220) then raise ERR end

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
