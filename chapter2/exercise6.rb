# Exercise 6
# Order doesnt matter

def randomize(arr)
  max_i = arr.size-1
  for i in 0..max_i-1
    j = rand(i..max_i)
    arr[i],arr[j] = arr[j],arr[i]
  end
  return arr
end

def dealCards(players)
  cards = Array.new
  for i in 1..52 do cards << i end
  randomize(cards)
  result = Array.new
  i = 0
  players.times {
    p = Array.new
    5.times {
      p << cards[i]
      i+=1
    }
    result << p
  }
  return result
end
