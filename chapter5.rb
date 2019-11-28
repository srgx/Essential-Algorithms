# Exercise 1
# When one stack is full nextIndex1>nextIndex2
# nextIndex1 is pointer to first item of second stack
# nextIndex2 is pointer to first item of first stack

class DoubleStack
  def initialize(size)
    @stack=Array.new(size)
    @nextIndex1=0
    @nextIndex2=size-1
  end
  
  def pushLeft(value)
    if(@nextIndex1>@nextIndex2) then raise "Stack is full" end
    @stack[@nextIndex1]=value
    @nextIndex1+=1
  end
  
  def pushRight(value)
    if(@nextIndex1>@nextIndex2) then raise "Stack is full" end
    @stack[@nextIndex2]=value
    @nextIndex2-=1
  end
  
  def show
    p @stack
  end
end

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

# Exercise 5
# It is possible to sort train with one holding track and output track (for current item)

# Exercise 6

stack2=Cell.new
push(stack2,4)
push(stack2,2)
push(stack2,1)
push(stack2,5)
push(stack2,7)
push(stack2,3)
push(stack2,6)


def stackSelectionSort(stack)
  temp_stack=Cell.new
  num_items=stackSize(stack)
  0.upto(num_items-1) do |i|
    max=pop(stack)
    (num_items-i-1).times do
      v=pop(stack)
      if(v>max)
        push(temp_stack,max)
        max=v
      else
        push(temp_stack,v)
      end
    end
    push(stack,max)
    while((v=pop(temp_stack))!=:empty)
      push(stack,v)
    end
  end
end

stackSelectionSort(stack2)

1.upto(stackSize(stack2)) do |i|
  if(pop(stack2)!=i) then raise ERR end
end

# Exercise 8
class CellP
  attr_accessor :next, :prev, :value, :priority
end

topSentinel=CellP.new
bottomSentinel=CellP.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel

def enqueueAfter(after,value,priority)
  new_cell=CellP.new
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


enqueue(topSentinel,"bronze",2)
enqueue(topSentinel,"best",5)
enqueue(topSentinel,"worst",1)
enqueue(topSentinel,"gold",4)
enqueue(topSentinel,"silver",3)


if(dequeue(topSentinel)!="best") then raise ERR end
if(dequeue(topSentinel)!="gold") then raise ERR end
if(dequeue(topSentinel)!="silver") then raise ERR end
if(dequeue(topSentinel)!="bronze") then raise ERR end
if(dequeue(topSentinel)!="worst") then raise ERR end
if(topSentinel.next.value!=nil) then raise ERR end



