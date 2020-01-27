require_relative 'exercise8.rb'
require_relative 'exercise13.rb'
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
    if((Algorithm.euclid(a,n)==1)&&((a**(n-1)-1)%n!=0))
      r=false
      break
    end
  end
  return r
end


def generateCarmichael(limit)
  numbers,primes = [],Algorithm.sieve(limit)
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
