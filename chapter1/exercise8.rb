# Exercise 8
# Runtime is O(N^3)

def countCubes(n)
  if(n==1)
    return 1
  else
    return n*(n+1)/2+countCubes(n-1)
  end
end

def countCubes2(n)
  s=0
  1.upto(n) { |i| s+=i*(i+1)/2 }
  return s
end


ERR = "Error"
R = 1540

raise ERR if countCubes(20) != R
raise ERR if countCubes2(20) != R
