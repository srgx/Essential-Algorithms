# Exercise 4
# Fair die: ~1.5%(6!/6**6), worse with biased die

def biasedSix
  loop do
    rands = []
    6.times { rands << rand(1..6) }
    f=true
    for i in 1..6
      if(!rands.include?(i))
        f=false
        break
      end
    end
    return rands[0] if f
  end
end
