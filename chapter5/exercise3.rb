require_relative 'exercise2.rb'
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



NUMS=[5,3,6,2,4,7,1]
ERR = "Error"
aStack = Cell.new
NUMS.each { |i| push(aStack,i)}
stackInsertionSort(aStack)
raise ERR if (stackSize(aStack)!=7)
1.upto(stackSize(aStack)) { |i| raise ERR if(pop(aStack)!=i) }
