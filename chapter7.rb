# Exercise 1

def linearSearch(array,value) # for sorted array
  0.upto(array.size-1) do |i|
    if(array[i]==value) then return i end
    if(array[i]>value) then return :no_index end
  end
  return :no_index
end

# Exercise 2

def linearSearchR(array,value,index)
  if(array[index].nil?)then return :no_index end
  if(array[index]==value) then return index end
  linearSearchR(array,value,index+1)
end

# Exercise 3
class Cell
  attr_accessor :value,:next
end

def addAtBeginning(sentinel,value)
  new_cell=Cell.new
  new_cell.value=value
  new_cell.next=sentinel.next
  sentinel.next=new_cell
end

def linearSearchLinked(sentinel,value)
  index=0
  while(sentinel.next!=nil)
    if(sentinel.next.value==value)then return index end
    if(sentinel.next.value>value)then return :no_index end
    index+=1
    sentinel=sentinel.next
  end
  return :no_index
end


# Exercise 4
def binarySearch(array,value)
  min=0
  max=array.size-1
  while(min<=max)
    mid=(min+max)/2
    if(value<array[mid])
      max=mid-1
    elsif(value>array[mid])
      min=mid+1
    else
      return mid
    end
  end
  return :no_index
end

# Exercise 5
def binarySearchR(array,value,min,max) # min and max indices
  if(min>max) then return :no_index end
  mid=(min+max)/2
  if(value<array[mid])
    binarySearchR(array,value,min,mid-1)
  elsif(value>array[mid])
    binarySearchR(array,value,min+1,max)
  else
    return mid
  end
end

# Exercise 6
# ...


# -------------------------------------------------------------------------
ERR="Error"
numbers=[12,33,43,56,99]
s=numbers.size
unless(linearSearch(numbers,2)==:no_index) then raise ERR end
unless(linearSearch(numbers,100)==:no_index) then raise ERR end
unless(linearSearch(numbers,44)==:no_index) then raise ERR end
unless(linearSearch(numbers,99)==4) then raise ERR end
unless(linearSearch(numbers,12)==0) then raise ERR end
unless(linearSearch(numbers,43)==2) then raise ERR end
# -------------------------------------------------------------------------
unless(linearSearchR(numbers,2,0)==:no_index) then raise ERR end
unless(linearSearchR(numbers,100,0)==:no_index) then raise ERR end
unless(linearSearchR(numbers,44,0)==:no_index) then raise ERR end
unless(linearSearchR(numbers,99,0)==4) then raise ERR end
unless(linearSearchR(numbers,12,0)==0) then raise ERR end
unless(linearSearchR(numbers,43,0)==2) then raise ERR end
# -------------------------------------------------------------------------
sentinel=Cell.new
[99,67,45,33,2,1].each { |i| addAtBeginning(sentinel,i) }
if(linearSearchLinked(sentinel,12)!=:no_index) then raise ERR end
if(linearSearchLinked(sentinel,100)!=:no_index) then raise ERR end
if(linearSearchLinked(sentinel,46)!=:no_index) then raise ERR end
if(linearSearchLinked(sentinel,33)!=2) then raise ERR end
if(linearSearchLinked(sentinel,1)!=0) then raise ERR end
if(linearSearchLinked(sentinel,99)!=5) then raise ERR end
# -------------------------------------------------------------------------
unless(binarySearch(numbers,2)==:no_index) then raise ERR end
unless(binarySearch(numbers,100)==:no_index) then raise ERR end
unless(binarySearch(numbers,44)==:no_index) then raise ERR end
unless(binarySearch(numbers,99)==4) then raise ERR end
unless(binarySearch(numbers,12)==0) then raise ERR end
unless(binarySearch(numbers,43)==2) then raise ERR end
# -------------------------------------------------------------------------
unless(binarySearchR(numbers,2,0,s-1)==:no_index) then raise ERR end
unless(binarySearchR(numbers,100,0,s-1)==:no_index) then raise ERR end
unless(binarySearchR(numbers,44,0,s-1)==:no_index) then raise ERR end
unless(binarySearchR(numbers,99,0,s-1)==4) then raise ERR end
unless(binarySearchR(numbers,12,0,s-1)==0) then raise ERR end
unless(binarySearchR(numbers,43,0,s-1)==2) then raise ERR end
# -------------------------------------------------------------------------

