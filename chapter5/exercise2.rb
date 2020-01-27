# Exercise 2

class Cell
  attr_accessor :value, :next
end

def push(sentinel,new_value)
  new_cell=Cell.new
  new_cell.value=new_value
  new_cell.next=sentinel.next
  sentinel.next=new_cell
end

def pop(sentinel)
  if(sentinel.next.nil?) then return :empty end
  result=sentinel.next.value
  sentinel.next=sentinel.next.next
  return result
end

def reverseStack(stackSentinel)
  newStack=Cell.new
  while((v=pop(stackSentinel))!=:empty)
    push(newStack,v)
  end
  return newStack
end

def showStack(stack)
  while(stack.next!=nil)
    puts stack.next.value
    stack=stack.next
  end
end

def stackSize(stack)
  s=0
  while(stack.next!=nil)
    s+=1
    stack=stack.next
  end
  return s
end
