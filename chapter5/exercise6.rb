require_relative 'exercise2.rb'
require_relative 'exercise3.rb'
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


stack=Cell.new
[4,2,1,5,7,3,6].each { |i| push(stack,i) }
stackSelectionSort(stack)
1.upto(stackSize(stack)) { |i| raise ERR if(pop(stack)!=i) }
