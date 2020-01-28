require_relative 'exercise4.rb'
# Exercise 5

def len(top)
  l=0
  while(top.next.value<Float::INFINITY)
    l+=1
    top=top.next
  end
  return l
end
