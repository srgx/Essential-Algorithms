def containsDuplicates(array)
  0.upto(array.size-1) do |i|
    0.upto(array.size-1) do |j|
      if(i!=j)
        if(array[i] == array[j]) then return true end
      end
    end
  end
  return false
end

def containsDuplicates2(array)
  0.upto(array.size-2) do |i|
    (i+1).upto(array.size-1) do |j|
      if(array[i] == array[j]) then return true end
    end
  end
  return false
end

err = "ERROR"

noDups = [12,33,4,7,99]
dups = [12,33,4,7,4,99]

if containsDuplicates(noDups) then raise err end
if !containsDuplicates(dups) then raise err end
if containsDuplicates2(noDups) then raise err end
if !containsDuplicates2(dups) then raise err end

# Exercise 1
# Runtime is O(N^2)

# Exercise 2
STEPS_PER_SECOND = 1000000
STEPS_PER_MINUTE = STEPS_PER_SECOND * 60
STEPS_PER_HOUR = STEPS_PER_MINUTE * 60
STEPS_PER_DAY = STEPS_PER_HOUR * 24
STEPS_PER_WEEK = STEPS_PER_DAY * 7
STEPS_PER_YEAR = STEPS_PER_DAY * 365

# n!
# second: 9, minute: 11, hour: 12, day: 13, week: 14, year: 16

# 2^n
# second: 19, minute: 25, hour: 31, day: 36, week: 39, year: 44

# n^2
# second: 1000, minute: 7745, hour: 60000, day: 293938, week: 777688, year: 5615692

# n
# second: 1000.000, minute: 60.000.000, hour: 3600.000.000, day: 86400.000.000,
# week: 604800.000.000, year: 31536.000.000.000

# sqrt(n)
# second: 1000.000.000.000, minute: 3600.000.000.000.000, hour: 12960.000.000.000.000.000,
# day: 7464960.000.000.000.000.000, week: 365783040.000.000.000.000.000,
# year: 994519296.000.000.000.000.000.000

# log 2 n
# second: 2**STEPS_PER_SECOND, minute: 2**STEPS_PER_MINUTE, hour: 2**STEPS_PER_HOUR,
# day: 2**STEPS_PER_DAY, week: 2**STEPS_PER_WEEK, year: 2**STEPS_PER_YEAR

# Exercise 3
# For n>50 1500*n is better than 30*(n**2), for n==50 they are equal

def ex3
  1.upto(60) do |n|
    f = 1500*n
    s = 30*n**2
    puts n
    if(f<s)
      puts "1500*n better"
    elsif(f==s)
      puts "equal"
    else
      puts "30*n**2 better"
    end
  end
end

# ex3

# Exercise 4
# Algorithm n/2+8 is better for all values except n(6-15)(worse) and n(4,5,16)(equal)

def ex4
  1.upto(30) do |n|
    f = n**3/75-n**2/4+n+10
    s = n/2+8
    puts n
    if(f>s)
      puts "n/2+8 better"
    elsif(f==s)
      puts "equal"
    else
      puts "n**3/75-n**2/4+n+10 better"
    end
  end
end

# ex4

# Exercise 5
# Runtime is O(N^2)

LETTERS = ["A","B","C","D"]
def pairs(le)
  res = []
  0.upto(le.size-1) do |i|
    (i+1).upto(le.size-1) do |j|
      res << [le[i],le[j]]
    end
  end
  return res
end

LETTER_PAIRS = [["A", "B"], ["A", "C"], ["A", "D"], ["B", "C"], ["B", "D"], ["C", "D"]]

if pairs(LETTERS)!=LETTER_PAIRS then raise err end


# Exercise 6
# Runtime is 6*n**2, O(N^2)

# Exercise 7
# Number of cubes is 12*n-(2*8), 12 edges minus 2 times corners(counted 3 times)
# Runtime is O(N)

def cubes(n)
  return 12*n-2*8
end

# Exercise 11
# Fibonacci function is better than 2**x/10 but worse than x**2/5

def fibonacci(n)
  arr = Array.new(n+1)
  arr[0] = 1
  arr[1] = 1
  2.upto(n) do |i|
    arr[i] = arr[i-1] + arr[i-2]
  end
  return arr[n]
end

def fibonacci2(n)
  return (n==0||n==1) ? 1 : fibonacci2(n-1) + fibonacci2(n-2)
end

def fibonacci3(n)
  w = (1+Math.sqrt(5))/2
  res = w**n/Math.sqrt(5)
  return res.round
end


X = 30
FIBORES = 1346269
if fibonacci(X)!=FIBORES then raise err end
if fibonacci2(X)!=FIBORES then raise err end
if fibonacci3(X+1)!=FIBORES then raise err end

# Exercise 10
# ...


