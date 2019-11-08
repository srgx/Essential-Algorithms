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
stepsPerSecond = 1000000
stepsPerMinute = stepsPerSecond * 60
stepsPerHour = stepsPerMinute * 60
stepsPerDay = stepsPerHour * 24
stepsPerWeek = stepsPerDay * 7
stepsPerYear = stepsPerDay * 365

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
# second: 2**stepsPerSecond, minute: 2**stepsPerMinute, hour: 2**stepsPerHour, day: 2**stepsPerDay,
# week: 2**stepsPerWeek, year: 2**stepsPerYear

# Exercise 3
# For n>50 1500*n is better than 30*(n**2), for n==50 they are equal

1.upto(60) do |n|
  f = 1500*n
  s = 30*n**2
  puts n
  if(f<s)
    puts "1500*n better"
  elsif(f==s)
    puts "Equal"
  else
    puts "30*(n**2) better"
  end
end

# Exercise 4
# Algorithm n/2+8 is better for all values except n(6-15)(worse) and n(4,5,16)(equal)

1.upto(30) do |n|
  f = n**3/75-n**2/4+n+10
  s = n/2+8
  puts n
  if(f>s)
    puts "n/2+8 better"
  elsif(f==s)
    puts "Equal"
  else
    puts "n**3/75-n**2/4+n+10 better"
  end
end

# Exercise 5
# ...

