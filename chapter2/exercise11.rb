# Exercise 11

def modExp(a,p,m)
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
  product=arr[i]%m # modified
  while(r<p)
    while(r+n>p)
      n/=2
      i-=1
    end
    r+=n
    product=(product*arr[i])%m # modified
  end
  return product
end


0.upto(T) do |i|
  1.upto(T) do |j|
    1.upto(T) do |k|
      if modExp(i,j,k)!=(i**j)%k then raise "Error for values #{i},#{j}" end
    end
  end
end
