# Exercise 2

def fibonacci(n)
  return n<=1 ? n : fibonacci(n-1) + fibonacci(n-2)
end

raise ERR if(fibonacci(6)!=8)
raise ERR if(fibonacci(7)!=13)
raise ERR if(fibonacci(8)!=21)
raise ERR if(fibonacci(9)!=34)
