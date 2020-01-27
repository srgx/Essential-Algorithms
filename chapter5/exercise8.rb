require_relative 'exercise3.rb'
# Exercise 8

class DoubleCell
  attr_accessor :next, :prev, :value, :priority
end

def enqueueAfter(after,value,priority=0)
  new_cell=DoubleCell.new
  new_cell.priority=priority
  new_cell.value=value

  new_cell.next=after.next
  new_cell.prev=after

  new_cell.next.prev=new_cell
  after.next=new_cell
end

def enqueue(top,value,priority)
  while(top.next.value!=nil&&top.next.priority>priority)
    top=top.next
  end
  enqueueAfter(top,value,priority)
end

def dequeue(top)
  if(top.next.value.nil?) then raise "Queue empty" end
  result=top.next.value
  top.next=top.next.next
  top.next.prev=top
  return result
end

def showFromTop(top)
  while(top.next.value!=nil)
    puts top.next.value
    top=top.next
  end
end

def showFromBot(bot)
  while(bot.prev.value!=nil)
    puts bot.prev.value
    bot=bot.prev
  end
end


topSentinel=DoubleCell.new
bottomSentinel=DoubleCell.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel

enqueue(topSentinel,"bronze",2)
enqueue(topSentinel,"best",5)
enqueue(topSentinel,"worst",1)
enqueue(topSentinel,"gold",4)
enqueue(topSentinel,"silver",3)

raise ERR if(dequeue(topSentinel)!="best")
raise ERR if(dequeue(topSentinel)!="gold")
raise ERR if(dequeue(topSentinel)!="silver")
raise ERR if(dequeue(topSentinel)!="bronze")
raise ERR if(dequeue(topSentinel)!="worst")
raise ERR if(topSentinel.next.value!=nil)
