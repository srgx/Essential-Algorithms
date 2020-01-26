# Exercise 7
# Program produces expected values for ~30.000 trials

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
