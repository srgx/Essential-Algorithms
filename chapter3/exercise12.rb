require_relative 'exercise1.rb'
# Exercise 12

noLoop=Cell.new
5.downto(1) { | n | addAtBeginning(noLoop,Cell.new(n)) }

withLoop=Cell.new
lastCell=Cell.new(9)
midCell=Cell.new(4) # loop starts here
addAtBeginning(withLoop,lastCell)
8.downto(5) { | n | addAtBeginning(withLoop,Cell.new(n)) }
addAtBeginning(withLoop,midCell)
3.downto(1) { | n | addAtBeginning(withLoop,Cell.new(n)) }
lastCell.next=midCell


def reverseList(sentinel)
  prev_cell=nil
  curr_cell=sentinel
  while(curr_cell!=nil) # curr_cell.next can be nil
    next_cell=curr_cell.next
    curr_cell.next=prev_cell
    prev_cell=curr_cell
    curr_cell=next_cell
  end
  return prev_cell
end

def hasLoopReversing(sentinel)
  if(sentinel.next.nil?) then return false end
  new_sentinel=reverseList(sentinel)
  reverseList(new_sentinel)
  return new_sentinel==sentinel
end


if(hasLoopReversing(noLoop)) then raise ERR end
unless(hasLoopReversing(withLoop)) then raise ERR end


def tortoiseHare(sentinel)
  tortoise=hare=sentinel
  while(!(hare.next.nil?||hare.next.next.nil?))
    tortoise,hare=tortoise.next,hare.next.next
    if(hare==tortoise) # first meeting, loop found
      hare=sentinel # reset hare
      # move to meet again at loop start
      while(hare!=tortoise)
        tortoise,hare=tortoise.next, hare.next # hare is slow
      end
      # hare is waiting for tortoise at loop start
      while(tortoise.next!=hare)
        tortoise=tortoise.next
      end
      tortoise.next=nil # break loop
      return true
    end
  end
  return false
end

raise ERR if(tortoiseHare(noLoop))
raise ERR unless(tortoiseHare(withLoop)) # break loop
raise ERR if(tortoiseHare(withLoop))
raise ERR if(hasLoopReversing(withLoop))
