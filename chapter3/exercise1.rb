# Exercise 1

class Cell
  attr_accessor :value, :next
  def initialize(n=nil) @value=n end
end

def iter(top)
  while(top.next!=nil)
    puts top.next.value
    top=top.next
  end
end

def addAtBeginning(top,new_cell)
  new_cell.next=top.next
  top.next=new_cell
end

def findCellBefore(top,value)
  while(top.next!=nil)
    if(top.next.value==value)then return top end
    top=top.next
  end
  return nil
end

def listLength(sentinel)
  l=0
  while(sentinel.next!=nil)
    l+=1
    sentinel=sentinel.next
  end
  return l
end

# Return updated bottom
def addAtEnd(bottom,new_cell)
  bottom.next=new_cell
  return new_cell
end


# Return updated bottom
def deleteAfter(after_me,bottom)
  if(after_me.next.next.nil?) then bottom = after_me end
  after_me.next=after_me.next.next
  return bottom
end


ERR="Error"


sentinel=Cell.new
bottom=Cell.new(42)
addAtBeginning(sentinel,bottom)
[12,38,80,2,16].each { | n | addAtBeginning(sentinel,Cell.new(n)) }
raise ERR unless(listLength(sentinel)==6)
bottom=addAtEnd(bottom,Cell.new(68))
bottom=addAtEnd(bottom,Cell.new(69))
bottom=addAtEnd(bottom,Cell.new(70))
raise ERR unless(bottom.value==70)
raise ERR unless(listLength(sentinel)==9)
cell69=findCellBefore(sentinel,70)
bottom=deleteAfter(cell69,bottom)
raise ERR unless(listLength(sentinel)==8)
raise ERR unless(bottom.value==69)


sentinel=Cell.new
bottom=Cell.new(33)
addAtBeginning(sentinel,bottom)
raise ERR if(listLength(sentinel)!=1)
bottom=deleteAfter(sentinel,bottom)
raise ERR if(listLength(sentinel)!=0)
raise ERR unless(bottom==sentinel)
bottom=addAtEnd(bottom,Cell.new(2))
raise ERR if(listLength(sentinel)!=1)
raise ERR unless(bottom.value==2)
