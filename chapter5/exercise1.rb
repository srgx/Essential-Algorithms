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
