require_relative 'exercise5.rb'
# Exercise 10

# j<=i, k<=j

# 0 0 0 - 0
# 1 0 0 - 1
# 1 1 0 - 2
# 1 1 1 - 3
# 2 0 0 - 4
# 2 1 0 - 5
# 2 1 1 - 6
# 2 2 0 - 7
# 2 2 1 - 8
# 2 2 2 - 9

def tetrahedral(rows)
  return (rows**3+3*(rows**2)+2*rows)/6
end


def findIndexT(x,y,z)
  return tetrahedral(x)+sum_to(y)+z
end

indexT=0
0.upto(3) do |i|
  0.upto(i) do |j|
    0.upto(j) do |k|
      if(findIndexT(i,j,k)!=indexT) then raise ERR end
      indexT+=1
    end
  end
end
