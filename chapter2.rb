# Exercise 1
def coinFlip
  n = rand(6)+1
  puts n
  return n>3 ? "heads" : "tails"
end

# Exercise 2
# No result probability is 0.625(62,5%)
heads = 3.0/4
tails = 1.0/4
two_heads = heads**2
two_tails = tails**2
no_res_probability = two_heads+two_tails

# Exercise 3
# No result probability is 0.5(50%)
heads2 = 1.0/2
tails2 = 1.0/2
two_heads2 = heads2**2
two_tails2 = tails2**2
no_res_probability2 = two_heads2+two_tails2

# Exercise 4
# Fair die: ~1.5%(6!/6**6), worse with biased die
def biasedSix
  loop do
    rands = []
    6.times { rands << rand(6)+1 }
    f=true
    1.upto(6) do |i|
      if(!rands.include?(i))
        f=false
        break
      end
    end
    return rands[0] if f
  end
end


# Exercise 5
# Runtime is O(M)

def pick(arr,m)
  max_i = arr.size-1
  0.upto(m-1) do |i|
    j = rand(i..max_i)
    arr[i],arr[j] = arr[j],arr[i]
  end
  return arr[0..m-1]
end


# Exercise 6
# Order doesnt matter

def randomize(arr)
  max_i = arr.size-1
  0.upto(max_i-1) do |i|
    j = rand(i..max_i)
    arr[i],arr[j] = arr[j],arr[i]
  end
  return arr
end


def dealCards(players)
  cards = []
  1.upto(52) { |i| cards << i }
  randomize(cards)
  result = []
  i = 0
  players.times do
    p = []
    5.times do
      p << cards[i]
      i+=1
    end
    result << p
  end
  return result
end



# Exercise 7

def twoSix
  a=rand(1..6)
  b=rand(1..6)
  return a+b
end

def trials(t)
  r = Array.new(11,0)
  t.times { r[twoSix-2]+=1 }
  2.upto(12) do |i|
    p = r[i-2]/t.to_f*100
    puts "#{i} - #{p.round}%"
  end
  return r
end


# Exercise 8
# If m<n algorithm changes order of arguments

def euclid(m,n)
  while(n!=0)
    r=m%n
    m=n
    n=r
  end
  return m
end

# Exercise 10

def exponentiation(a,p)
  if([0,1].include?(p)) then return [1,a][p] end
  n=1
  arr=[]
  while(n<p)
    arr << a**n
    n*=2
  end
  n/=2
  r=n
  i=arr.size-1
  product=arr[i]
  loop do
    while(r+n>p)
      n/=2
      i-=1
    end
    r+=n
    product*=arr[i]
    break if r>=p
  end
  return product
end


T = 200

0.upto(T) do |i|
  0.upto(T) do |j|
    if exponentiation(i,j)!=i**j then raise "Error for values #{i},#{j}" end
  end
end


# Exercise 14
# [[561, [3, 11, 17]], [1105, [5, 13, 17]], [1729, [7, 13, 19]], 
# [2465, [5, 17, 29]], [2821, [7, 13, 31]], [6601, [7, 23, 41]], [8911, [7, 19, 67]]]

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


# Exercise 9
# Least common multiple
# g=GCD(a,b), A=g*m, B=g*n,
# A*B/GCD(a,b) = g*m*g*n/g = g*m*n
def lcd(a,b)
  return a*b/euclid(a,b)
end

# Exercise 18
# Root of function f(x)-g(x) is where functions intersect


# Exercise 15
# Middle rectangle can reduce error for increasing and decreasing curves

def poly(x)
  return x**2
end

def linear(x)
  return x*2
end

def constant(x)
  return 10
end

# Left
def rectangleRule(func,xmin,xmax,intervals)
  dx=(xmax-xmin)/intervals
  total_area=0
  x=xmin
  intervals.times do
    total_area = total_area + dx*send(func,x)
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
    total_area = total_area + dx*send(func,x)
    x+=dx
  end
  return total_area
end


if(rectangleRule(:poly,0,200,25)!=2508800) then raise "Error" end
if(rectangleRule2(:poly,0,200,25)!=2665600) then raise "Error" end


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


