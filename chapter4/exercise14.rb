# Exercise 14

class ArrayRow
  attr_accessor :row_number, :next_row, :row_sentinel
  def initialize(rn=nil,nr=nil,rs=nil)
    @row_number = rn
    @next_row = nr
    @row_sentinel = rs
  end
end

class ArrayEntry
  attr_accessor :column_number, :value, :next_entry
  def initialize(cn=nil,ne=nil,v=nil)
    @column_number = cn
    @next_entry = ne
    @value = v
  end
end

# normal matrices
def multiplyMatrices(a,b)
  result = [[0,0,0],[0,0,0],[0,0,0]]
  for i in 0..a.size-1
    for j in 0..a[0].size-1
      result[i][j]=0
      for k in 0..a[0].size-1
        result[i][j]+=(a[i][k]*b[k][j])
      end
    end
  end
  return result
end


def showRows(sentinel)
  while(sentinel.next_row!=nil)
    puts sentinel.next_row.row_number
    sentinel=sentinel.next_row
  end
end

def copyEntries(row,sent)
  sentinel=row.row_sentinel
  r=row.row_number
  while(sentinel.next_entry!=nil)
    c=sentinel.next_entry.column_number
    v=sentinel.next_entry.value
    setValue(r,c,v,sent)
    sentinel=sentinel.next_entry
  end
end

def setValue(row,column,value,sentinel)
  default = 0

  if(value == default)
    deleteEntry(row,column,sentinel)
    return
  end


  array_row = findRowBefore(row,sentinel)
  if(array_row.next_row.nil? || array_row.next_row.row_number>row)
    new_row = ArrayRow.new(row,array_row.next_row,ArrayEntry.new)
    array_row.next_row = new_row
  end
  array_row = array_row.next_row


  array_entry = findColumnBefore(column,array_row.row_sentinel)
  if(array_entry.next_entry.nil? || array_entry.next_entry.column_number>column)
    new_entry = ArrayEntry.new(column,array_entry.next_entry)
    array_entry.next_entry = new_entry
  end
  array_entry = array_entry.next_entry
  array_entry.value = value

end

def deleteEntry(row,column,sentinel)
  array_row = findRowBefore(row,sentinel)
  if(array_row.next_row.nil? || array_row.next_row.row_number>row) then return end
  target_row = array_row.next_row
  array_entry = findColumnBefore(column,target_row.row_sentinel)
  if(array_entry.next_entry.nil? || array_entry.next_entry.column_number>column) then return end
  array_entry.next_entry = array_entry.next_entry.next_entry
  if(target_row.row_sentinel.next_entry.nil?)
    array_row.next_row=array_row.next_row.next_row
  end
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

def findRowBefore(row,sentinel)
  while(sentinel.next_row!=nil&&sentinel.next_row.row_number<row)
    sentinel=sentinel.next_row
  end
  return sentinel
end

def findColumnBefore(column,row_sentinel)
  array_entry=row_sentinel
  while(array_entry.next_entry!=nil&&array_entry.next_entry.column_number<column)
    array_entry=array_entry.next_entry
  end
  return array_entry
end

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

def addSparseMatrices(a,b)
  result = ArrayRow.new
  arr1_row=a.next_row
  arr2_row=b.next_row

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
  return result
end


ERR = "Error"

matrix1 = [[1,2,3],
           [4,5,6],
           [8,2,55]]

matrix2 = [[7,8,9],
           [12,1,33],
           [5,6,2]]

res = multiplyMatrices(matrix1,matrix2)

raise ERR if(res!=[[46, 28, 81],
                   [118, 73, 213],
                   [355, 396, 248]])




spar1 = ArrayRow.new
spar2 = ArrayRow.new

setValue(0,0,5,spar1)
setValue(0,1,5,spar1)
setValue(1,0,8,spar1)
setValue(1,1,20,spar1)

setValue(0,0,5,spar2)
setValue(0,1,15,spar2)
setValue(1,0,22,spar2)
setValue(1,1,7,spar2)
setValue(2,2,33,spar2)

sparres = addSparseMatrices(spar1,spar2)

raise ERR if(getValue(0,0,sparres)!=10)
raise ERR if(getValue(0,1,sparres)!=20)
raise ERR if(getValue(1,0,sparres)!=30)
raise ERR if(getValue(1,1,sparres)!=27)
raise ERR if(getValue(2,2,sparres)!=33)

deleteEntry(2,2,sparres)
raise ERR if(getValue(2,2,sparres)!=0)

=begin

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

=end
