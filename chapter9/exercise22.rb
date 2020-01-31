require_relative 'exercise21.rb'
# Exercise 22

def nonRecFibo(n)
  if(n>$maxN)
    ($maxN+1).upto(n) do |i|
      $fiboValues[i] = nonRecFibo(i-1) + nonRecFibo(i-2)
    end
    $maxN = n
  end
  return $fiboValues[n]
end

# FIBONACCI
initFibo
raise "Error" if fibo(7)!=13
initFibo
raise "Error" if nonRecFibo(7)!=13
