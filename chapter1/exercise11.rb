# Exercise 11
# Fibonacci function is better than 2**x/10 but worse than x**2/5

def fibonacci(n)
  arr = Array.new(n+1)
  arr[0] = 1
  arr[1] = 1
  2.upto(n) do |i|
    arr[i] = arr[i-1] + arr[i-2]
  end
  return arr[n]
end

def fibonacci2(n)
  return (n==0||n==1) ? 1 : fibonacci2(n-1) + fibonacci2(n-2)
end

def fibonacci3(n)
  w = (1+Math.sqrt(5))/2
  res = w**n/Math.sqrt(5)
  return res.round
end

ERR = "Error"
X = 30
FIBORES = 1346269


raise ERR if fibonacci(X)!=FIBORES
raise ERR if fibonacci2(X)!=FIBORES
raise ERR if fibonacci3(X+1)!=FIBORES
