require_relative 'exercise1.rb'
# Exercise 9

def isSortedAsc(top)
  if(top.next==nil||top.next.next.nil?) then return true end
  while(top.next.next!=nil)
    if(top.next.value>top.next.next.value) then return false end
    top=top.next
  end
  return true
end

unsorted = Cell.new
1.upto(5) { | n | addAtBeginning(unsorted,Cell.new(n)) } # [5,4,3,2,1]
sorted = Cell.new
5.downto(1) { | n | addAtBeginning(sorted,Cell.new(n)) } # [1,2,3,4,5]


raise ERR if(isSortedAsc(unsorted))
raise ERR unless(isSortedAsc(sorted))
