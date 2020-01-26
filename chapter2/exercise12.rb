# Exercise 12
# Number of steps grows very slowly

def gcdSteps(m,n)
  steps=0
  while(n!=0)
    steps+=1
    r=m%n
    m=n
    n=r
  end
  return steps
end


def generatePairs(n)
  pairs = []
  n.times do
    p = []
    2.times { p << rand(1..100000) }
    pairs << p
  end
  return pairs
end

def stepsAv(n)
  pairs = generatePairs(n)
  result = []
  pairs.each do |p|
    c=[]
    average = (p[0]+p[1])/2.0
    steps = gcdSteps(p[0],p[1])
    c << average
    c << steps
    result << c
  end
  return result
end
