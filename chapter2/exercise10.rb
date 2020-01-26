# Exercise 10

def exponentiation(a,p)
  n=1
  arr=[]
  while(n<=p)
    arr << a
    a=a**2
    n*=2
  end
  n/=2
  r=n
  i=arr.size-1
  product=arr[i]
  while(r<p)
    while(r+n>p)
      n/=2
      i-=1
    end
    r+=n
    product*=arr[i]
  end
  return product
end

T = 100

0.upto(T) do |i|
  1.upto(T) do |j|
    if exponentiation(i,j)!=i**j then raise "Error for values #{i},#{j}" end
  end
end
