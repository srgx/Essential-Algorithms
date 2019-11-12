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
  0.upto(max_i) do |i|
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


