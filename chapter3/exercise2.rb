require_relative 'exercise1.rb'
# Exercise 2

def findMaxCell(top)
  if((nc=top.next)==nil) then return nil end
  mc=top=nc
  while((nc=top.next)!=nil)
    if(nc.value>mc.value) then mc=nc end
    top=top.next
  end
  return mc
end


sentinel=Cell.new
sentinel2=Cell.new
[12,38,80,2,16].each { | n | addAtBeginning(sentinel,Cell.new(n)) }
max_cell=findCellBefore(sentinel,80).next

raise ERR unless(findCellBefore(sentinel,9).nil?)
raise ERR unless(findMaxCell(sentinel2).nil?)
raise ERR if(findMaxCell(sentinel)!=max_cell)
