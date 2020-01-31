# Exercise 21

def initFibo
  $fiboValues = Array.new(100)
  $fiboValues[0] = 0
  $fiboValues[1] = 1
  $maxN = 1
end

def fibo(n)
  if($maxN<n)
    $fiboValues[n] = fibo(n-1) + fibo(n-2)
    $maxN = n
  end
  return $fiboValues[n]
end
