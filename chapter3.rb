# Exercise 2
class Sentinel
  attr_accessor :next
end

class Cell
  attr_accessor :value, :next
  def initialize(n) @value=n end
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

sentinel=Sentinel.new
sentinel2=Sentinel.new
[12,38,80,2,16].each { | n | addAtBeginning(sentinel,Cell.new(n)) }
max_cell=findCellBefore(sentinel,80).next

def iter(top)
  while(top.next!=nil)
    puts top.next.value
    top=top.next
  end
end

def findMaxCell(top)
  if((nc=top.next)==nil) then return nc end
  mc=top=nc
  while((nc=top.next)!=nil)
    if(nc.value>mc.value) then mc=nc end
    top=top.next
  end
  return mc
end

ERR="Error"
unless(findCellBefore(sentinel,9).nil?) then raise ERR end
unless(findMaxCell(sentinel2).nil?) then raise ERR end
if(findMaxCell(sentinel)!=max_cell) then raise ERR end


