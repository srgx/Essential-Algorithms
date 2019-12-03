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

# Exercises 3, 4

def stackInsertionSort(stackSentinel)
  temp_stack=Cell.new
  num_items=stackSize(stackSentinel)
  0.upto(num_items-1) do |i|
    next_item=pop(stackSentinel)
    (num_items-i-1).times do # move all items to temp
      g=pop(stackSentinel)
      push(temp_stack,g)
    end
    while((v=pop(stackSentinel))!=:empty&&v<next_item) # push some sorted items to temp
      push(temp_stack,v)
    end
    if(v!=:empty) then push(stackSentinel,v) end
    push(stackSentinel,next_item)
    while((v=pop(temp_stack))!=:empty) # move all items from temp to stack
      push(stackSentinel,v)
    end
  end
end

def stackInsertionSort2(stackSentinel)
  temp_stack=Cell.new
  num_items=stackSize(stackSentinel)
  next_item=pop(stackSentinel)
  (num_items-1).times { push(temp_stack,pop(stackSentinel)) }
  0.upto(num_items-1) do |i|
    c=0
    while((v=pop(stackSentinel))!=:empty&&v<next_item) # push some sorted items to temp
      push(temp_stack,v)
      c+=1
    end
    if(v!=:empty) then push(stackSentinel,v) end
    push(stackSentinel,next_item)
    c.times { push(stackSentinel,pop(temp_stack)) } # move sorted items back from temp
    next_item=pop(temp_stack)
  end
end

# Exercise 5
# Stack insertion sort
# It is possible to sort train with one holding track and output track (for current item)

# Exercise 6

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

# Exercise 7
# Stack selection sort
# It is possible to sort train with one holding track and output track (for max or min element)

# Exercise 8

class CellD
  attr_accessor :next, :prev, :value
end

class CellP < CellD
  attr_accessor :priority
end

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

# Exercise 9
def enqueueFromTop(top,value)
  new_cell=CellD.new
  new_cell.value=value
  
  new_cell.next=top.next
  new_cell.prev=top
  
  new_cell.next.prev=new_cell
  top.next=new_cell
end

def enqueueFromBot(bot,value)
  new_cell=CellD.new
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

# Exercise 10
class Customer
  attr_reader :id, :waiting
  def initialize(id)
    @id=id
    @waiting=0
  end
  
  def update
    @waiting+=1
  end
end

class Teller
  def initialize(id,client_time)
    @id=id
    @left=0
    @client_time=client_time
  end
  
  def process(client)
    puts "Hello, Sir #{client.id}! I'm teller #{@id}."
    puts "You have been waiting #{client.waiting} minutes!"
    @left=@client_time
  end
  
  def update
    if (@left>0) then @left-=1 end
  end
  
  def free?
    return @left==0
  end
end

class Bank
  def initialize(tellers,client_time)
    @time=1
    @tellers=[]
    tellers.times { |i| @tellers << Teller.new(i,client_time) }
    @queue=[]
  end
  
  def getFreeTellers
    result=[]
    @tellers.each do |teller|
      if(teller.free?)
        result << teller
      end
    end
    return result
  end
  
  def update
    if(@time%3==0) then @queue << Customer.new(@time) end
    
    freeTellers=self.getFreeTellers
    freeTellers.each do |tlr|
      client=@queue.shift
      if(!client.nil?) then tlr.process(client) end
    end
    
    
    @tellers.each { |t| t.update }
    @queue.each { |c| c.update }
    
    puts "Time: #{@time}, Size: #{@queue.size}"
    @time+=1
    sleep(0.1)
  end
end

def bankSimulation
  bank=Bank.new(5,15) # tellers, time per client
  while(true)
    bank.update
  end
end

# bankSimulation


# Exercises 11, 12
def enqueue2(top,value)
  new_cell=CellD.new
  new_cell.value=value
  
  new_cell.next=top.next
  new_cell.prev=top
  
  new_cell.next.prev=new_cell
  top.next=new_cell
end

def dequeue2(bottom)
  if(bottom.prev.value.nil?) then return :empty end
  result=bottom.prev.value
  bottom.prev=bottom.prev.prev
  bottom.prev.next=bottom
  return result
end

def queueSize(top)
  s=0
  while(top.next.value!=nil)
    s+=1
    top=top.next
  end
  return s
end


def createTemp
  top_temp=CellD.new
  bot_temp=CellD.new
  top_temp.next=bot_temp
  bot_temp.prev=top_temp
  return [top_temp,bot_temp]
end


def queueSelectionSort(top,bot)
  r=createTemp
  top_temp,bot_temp=r[0],r[1]
  num_items=queueSize(top)
  0.upto(num_items-1) do |i|
    max=dequeue2(bot)
    (num_items-i-1).times do
      v=dequeue2(bot)
      if(v>max)
        enqueue2(top,max)
        max=v
      else
        enqueue2(top,v)
      end
    end
    enqueue2(top_temp,max) # move max to temp queue
  end
  
  while((v=dequeue2(bot_temp))!=:empty) # move all values from temp to destination
    enqueue2(top,v)
  end
end

def queueInsertionSort(top,bot)
  r=createTemp
  top_temp,bot_temp=r[0],r[1]
  num_items=queueSize(top)
  next_item=dequeue2(bot)
  1.upto(num_items-1) { enqueue2(top_temp,dequeue2(bot)) } # move all items to temp
  while(next_item!=:empty) do
    s,set=queueSize(top),false
    0.upto(s-1) do
      v=dequeue2(bot)
      if(next_item>v&&!set)
        enqueue2(top,next_item)
        enqueue2(top,v)
        set=true
      else
        enqueue2(top,v)
      end
    end
    if(!set) then enqueue2(top,next_item) end
    next_item=dequeue2(bot_temp)
  end
end


# ------------------------------------------------------------------------------
# QUEUE SELECTION SORT TEST
topSentinel=CellD.new
bottomSentinel=CellD.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel
[5,2,7,4,1,6,3].each { |i| enqueue2(topSentinel,i)}
queueSelectionSort(topSentinel,bottomSentinel)
7.downto(1) { |i| if(dequeue2(bottomSentinel)!=i) then raise ERR end }
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# QUEUE INSERTION SORT TEST
topSentinel=CellD.new
bottomSentinel=CellD.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel
[5,2,7,4,1,6,3].each { |i| enqueue2(topSentinel,i)}
queueInsertionSort(topSentinel,bottomSentinel)
7.downto(1) { |i| if(dequeue2(bottomSentinel)!=i) then raise ERR end }
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# DEQUE TEST
topSentinel=CellD.new
bottomSentinel=CellD.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel

enqueueFromTop(topSentinel,3)
enqueueFromTop(topSentinel,2)
enqueueFromTop(topSentinel,1)
enqueueFromBot(bottomSentinel,4)
enqueueFromBot(bottomSentinel,5)
if(dequeueFromTop(topSentinel)!=1) then raise ERR end
5.downto(2) { |i| if(dequeueFromBot(bottomSentinel)!=i) then raise ERR end }
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# PRIORITY QUEUE TEST
topSentinel=CellP.new
bottomSentinel=CellP.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel
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
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# STACK SELECTION SORT TEST
stack2=Cell.new
[4,2,1,5,7,3,6].each { |i| push(stack2,i) }
stackSelectionSort(stack2)
1.upto(stackSize(stack2)) { |i| if(pop(stack2)!=i) then raise ERR end }
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# STACK INSERTION SORT TESTS
NUMS=[5,3,6,2,4,7,1]
# TEST VERSION 1
aStack=Cell.new
NUMS.each { |i| push(aStack,i)}
stackInsertionSort(aStack)
if(stackSize(aStack)!=7) then raise ERR end
1.upto(stackSize(aStack)) { |i| if(pop(aStack)!=i) then raise ERR end }
# TEST VERSION 2
aStack=Cell.new
NUMS.each { |i| push(aStack,i)}
stackInsertionSort2(aStack)
if(stackSize(aStack)!=7) then raise ERR end
1.upto(stackSize(aStack)) { |i| if(pop(aStack)!=i) then raise ERR end }
# ------------------------------------------------------------------------------

