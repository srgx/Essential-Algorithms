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


aStack = Cell.new
push(aStack,4)
push(aStack,2)
push(aStack,5)
push(aStack,1)
push(aStack,3)


# Exercise 3

def popAll(stack)
  while((v=pop(stack))!=:empty)
    puts v
  end
end


def stackInsertionSort(stackSentinel)
  temp_stack=Cell.new
  num_items=5
  0.upto(num_items-1) do |i|
    next_item=pop(stackSentinel)
    (num_items-i-1).times do
      g=pop(stackSentinel)
      push(temp_stack,g)
    end
    
    set=false
    while((v=pop(temp_stack))!=:empty)
      if(v<next_item&&!set)
        push(stackSentinel,next_item)
        set=true
      end
      push(stackSentinel,v)
    end
    if(!set) then push(stackSentinel,next_item) end
  end
  
end


stackInsertionSort(aStack)

#popAll aStack





