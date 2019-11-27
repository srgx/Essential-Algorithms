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

ERR="Error"


aStack = Cell.new
push(aStack,5)
push(aStack,3)
push(aStack,6)
push(aStack,2)
push(aStack,4)
push(aStack,7)
push(aStack,1)

# Exercise 3

def stackInsertionSort(stackSentinel)
  temp_stack=Cell.new
  num_items=stackSize(stackSentinel)
  0.upto(num_items-1) do |i|
    next_item=pop(stackSentinel)
    (num_items-i-1).times do
      g=pop(stackSentinel)
      push(temp_stack,g)
    end
    while((v=pop(stackSentinel))!=:empty&&v<next_item)
      push(temp_stack,v)
    end
    if(v!=:empty) then push(stackSentinel,v) end
    push(stackSentinel,next_item)
    while((v=pop(temp_stack))!=:empty)
      push(stackSentinel,v)
    end
  end
end

stackInsertionSort(aStack)

1.upto(stackSize(aStack)) do |i|
  if(pop(aStack)!=i) then raise ERR end
end

