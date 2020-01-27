require_relative 'exercise1.rb'
# Exercise 7

class HeapQueue # priority queue
  attr_reader :values, :priorities
  def initialize
    @array_size=10
    @next_index=0
    @values = Array.new(@array_size)
    @priorities = Array.new(@array_size)
  end

  def enqueue(value,priority)
    if(@next_index>=@array_size) then raise "Queue is full!" end
    @values[@next_index]=value
    @priorities[@next_index]=priority

    index=@next_index
    while(index!=0)
      parent=(index-1)/2

      if(@priorities[index]<=@priorities[parent]) then break end


      swap(@values,index,parent)

      swap(@priorities,index,parent)

      index=parent
    end
    @next_index+=1
  end

  def dequeue
    if(@next_index==0) then raise "Queue empty!" end
    result=@values[0]
    @values[0]=@values[@next_index-1]
    @priorities[0]=@priorities[@next_index-1]
    index=0
    while(true)
      child1=2*index+1
      child2=2*index+2

      if(child1 >= @next_index) then child1=index end
      if(child2 >= @next_index) then child2=index end

      if(@priorities[index]>=@priorities[child1]&&
         @priorities[index]>=@priorities[child2]) then break end

      swap_child = @priorities[child1]>@priorities[child2] ? child1 : child2

      swap(@values,index,swap_child)
      swap(@priorities,index,swap_child)

      index=swap_child
    end
    @next_index-=1
    return result
  end
end


queue=HeapQueue.new
queue.enqueue("cat",12)
queue.enqueue("tiger",80)
queue.enqueue("mouse",5)
queue.enqueue("dog",8)
queue.enqueue("lion",90)
queue.enqueue("dragon",120)
queue.enqueue("fox",70)

sorted=["dragon","lion","tiger","fox","cat","dog","mouse"]
sorted.each do |a|
  if(queue.dequeue!=a) then raise ERR end
end
