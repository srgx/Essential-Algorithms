require_relative 'exercise8.rb'

# Exercise 9
# Least common multiple
# g=GCD(a,b), A=g*m, B=g*n,
# A*B/GCD(a,b) = g*m*g*n/g = g*m*n

def lcm(a,b)
  return a*b/Algorithm.euclid(a,b)
end
