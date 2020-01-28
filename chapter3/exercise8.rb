require_relative 'exercise6.rb'
# Exercise 8

def insertSorted(top,new_cell)
  while(new_cell.value>top.next.value)
    top=top.next
  end
  insertCell(top,new_cell)
end

minSent=DoubleCell.new(-Float::INFINITY) # top sentinel
maxSent=DoubleCell.new(Float::INFINITY) # bottom sentinel
minSent.next=maxSent
maxSent.previous=minSent
insertSorted(minSent,DoubleCell.new(54))
insertSorted(minSent,DoubleCell.new(12))
insertSorted(minSent,DoubleCell.new(1))
insertSorted(minSent,DoubleCell.new(33))
insertSorted(minSent,DoubleCell.new(7))
raise ERR unless(len(minSent)==5)
raise ERR unless(minSent.next.value==1)
raise ERR unless(maxSent.previous.value==54)
