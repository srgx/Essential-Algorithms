require_relative 'exercise3.rb'
# Exercise 4

def stackInsertionSort2(stackSentinel)
  temp_stack=Cell.new
  num_items=stackSize(stackSentinel)
  next_item=pop(stackSentinel)
  (num_items-1).times { push(temp_stack,pop(stackSentinel)) }
  0.upto(num_items-1) do |i|
    c=0
    while((v=pop(stackSentinel))!=:empty&&v<next_item)
      push(temp_stack,v)
      c+=1
    end
    if(v!=:empty) then push(stackSentinel,v) end
    push(stackSentinel,next_item)
    c.times { push(stackSentinel,pop(temp_stack)) }
    next_item=pop(temp_stack)
  end
end


aStack=Cell.new
NUMS.each { |i| push(aStack,i)}
stackInsertionSort2(aStack)
raise ERR if (stackSize(aStack)!=7)
1.upto(stackSize(aStack)) { |i| raise ERR if(pop(aStack)!=i) }
