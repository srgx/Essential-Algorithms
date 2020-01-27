require_relative 'exercise8.rb'
# Exercise 9

def enqueueFromTop(top,value)
  new_cell=DoubleCell.new
  new_cell.value=value

  new_cell.next=top.next
  new_cell.prev=top

  new_cell.next.prev=new_cell
  top.next=new_cell
end

def enqueueFromBot(bot,value)
  new_cell=DoubleCell.new
  new_cell.value=value

  new_cell.next=bot
  new_cell.prev=bot.prev

  new_cell.prev.next=new_cell
  bot.prev=new_cell
end

def dequeueFromTop(top)
  if(top.next.value.nil?) then return :empty end
  result=top.next.value
  top.next=top.next.next
  top.next.prev=top
  return result
end

def dequeueFromBot(bottom)
  if(bottom.prev.value.nil?) then return :empty end
  result=bottom.prev.value
  bottom.prev=bottom.prev.prev
  bottom.prev.next=bottom
  return result
end

topSentinel=DoubleCell.new
bottomSentinel=DoubleCell.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel

enqueueFromTop(topSentinel,3)
enqueueFromTop(topSentinel,2)
enqueueFromTop(topSentinel,1)
enqueueFromBot(bottomSentinel,4)
enqueueFromBot(bottomSentinel,5)
raise ERR if(dequeueFromTop(topSentinel)!=1)
5.downto(2) { |i| raise ERR if(dequeueFromBot(bottomSentinel)!=i) }
