require_relative 'exercise1'
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
    if(sentinel.next.value>value)then return -1 end
    index+=1
    sentinel=sentinel.next
  end
  return -1
end

sentinel = Cell.new
[99,67,45,33,2,1].each { |i| addAtBeginning(sentinel,i) }

raise ERR if(linearSearchLinked(sentinel,12)!=-1)
raise ERR if(linearSearchLinked(sentinel,100)!=-1)
raise ERR if(linearSearchLinked(sentinel,46)!=-1)
raise ERR if(linearSearchLinked(sentinel,33)!=2)
raise ERR if(linearSearchLinked(sentinel,1)!=0)
raise ERR if(linearSearchLinked(sentinel,99)!=5)
