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
# ...

