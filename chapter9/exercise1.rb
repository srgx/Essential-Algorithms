# Exercise 1

def factorial(n)
  return n.zero? ? 1 : n * factorial(n-1)
end

raise ERR if(factorial(3)!=6)
raise ERR if(factorial(4)!=24)
raise ERR if(factorial(5)!=120)
raise ERR if(factorial(6)!=720)
