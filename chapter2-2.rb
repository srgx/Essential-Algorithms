def euclid(m,n)
  while(n!=0)
    r=m%n
    m=n
    n=r
  end
  return m
end


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


# Exercise 13
# Start loop with current_prime**2, all smaller multiplies have already been marked

def sieve(n)
  is_composite = Array.new(n+1,false)
  (4..n).step(2) do |i|
    is_composite[i] = true
  end

  current_prime = 3
  stop_at = Integer.sqrt(n)

  while(current_prime <= stop_at)
    (current_prime**2..n).step(current_prime) { |i| is_composite[i] = true }

    #current_prime+=2
    #while((current_prime<=n)&&(is_composite[current_prime]))
    #  current_prime+=2
    #end

    loop do
      current_prime+=2
      break if(!((current_prime<=n)&&(is_composite[current_prime])))
    end

  end

  primes = []
  2.upto(n) do |i|
    if(!is_composite[i]) then primes << i end
  end

  return primes
end

PRIMES=[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]

if(sieve(50)!=PRIMES) then raise "Error" end


# Exercise 14
# [[561, [3, 11, 17]], [1105, [5, 13, 17]], [1729, [7, 13, 19]],
# [2465, [5, 17, 29]], [2821, [7, 13, 31]], [6601, [7, 23, 41]], [8911, [7, 19, 67]]]


def isPrime(n)
  if(n==1) then return false end
  r=true
  (n-1).downto(2) do |i|
    if(n%i==0)
      r=false
      break
    end
  end
  return r
end

def findFactors(number)
  factors = []
  i=2
  while(i<number)
    while(number%i==0)
      factors << i
      number/=i
    end
    i+=1
  end
  if(number>1) then factors << number end
  return factors
end

# improved version
def findFactors2(number)
  factors = []
  while(number%2==0)
    factors << 2
    number/=2
  end
  i=3
  max_factor=Integer.sqrt(number)
  while(i<=max_factor)
    while(number%i==0)
      factors << i
      number/=i
      max_factor=Integer.sqrt(number)
    end
    i+=2
  end
  if(number>1) then factors << number end
  return factors
end

NUM_1=127
NUM_2=500
NUM_3=1020
FACTORS_1=[127]
FACTORS_2=[2,2,5,5,5]
FACTORS_3=[2,2,3,5,17]
ERR="wrong prime factors"

if(findFactors(NUM_1)!=FACTORS_1) then raise ERR end
if(findFactors2(NUM_1)!=FACTORS_1) then raise ERR end
if(findFactors(NUM_2)!=FACTORS_2) then raise ERR end
if(findFactors2(NUM_2)!=FACTORS_2) then raise ERR end
if(findFactors(NUM_3)!=FACTORS_3) then raise ERR end
if(findFactors2(NUM_3)!=FACTORS_3) then raise ERR end


# For composite numbers
def isCarmichael(n)
  r=true
  (n-1).downto(2) do |a|
    if((euclid(a,n)==1)&&((a**(n-1)-1)%n!=0))
      r=false
      break
    end
  end
  return r
end


def generateCarmichael(limit)
  numbers,primes = [],sieve(limit)
  2.upto(limit) do |i|
    if((!primes.include?(i))&&(isCarmichael(i)))
      numbers << [i,findFactors2(i)]
    end
  end
  return numbers
end

CARMS=[[561, [3, 11, 17]], [1105, [5, 13, 17]],
       [1729, [7, 13, 19]], [2465, [5, 17, 29]], [2821, [7, 13, 31]]]


if(generateCarmichael(3000)!=CARMS) then raise "Error" end


# Exercise 15
# Middle rectangle can reduce error for increasing and decreasing curves


poly = lambda{ |x| x**2 }
linear = lambda { |x| x*2 }
constant = lambda { |x| 10 }


# Left
def rectangleRule(func,xmin,xmax,intervals)
  dx=(xmax-xmin)/intervals
  total_area=0
  x=xmin
  intervals.times do
    total_area = total_area + dx*func.call(x)
    x+=dx
  end
  return total_area
end

# Middle
def rectangleRule2(func,xmin,xmax,intervals)
  dx=(xmax-xmin)/intervals
  total_area=0
  x=xmin+dx/2
  intervals.times do
    total_area = total_area + dx*func.call(x)
    x+=dx
  end
  return total_area
end


if(rectangleRule(poly,0,200,25)!=2508800) then raise "Error" end
if(rectangleRule2(poly,0,200,25)!=2665600) then raise "Error" end


# Exercise 16
# Adaptive Monte Carlo algorithm picks points only in important areas
# If all points are inside or outside box, it adds or ignores box area


# Exercise 17
# monteCarlo3D(isInside(p),trials,x,y,z)
#   points_inside=0
#   trials.times
#     <pickRandomPoint(x,y,z)>
#     <if isInside(pickedPoint) points_inside++ >
#   end
#   volume=x*y*z
#   shapeVolume=volume*(points_inside/trials)
#   return shapeVolume
# end


# Exercise 18
# Root of function f(x)-g(x) is where functions intersect
