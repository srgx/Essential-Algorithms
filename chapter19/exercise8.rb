# Exercise 8
# Girls - 50%, Boys - 50%

def simulation
  boys = girls = 0
  for i in 1..10000
    loop do
      s = rand(2)
      if(s.zero?)
        boys += 1
        break
      else
        girls += 1
      end
    end
  end
  return [girls,boys]
end

=begin
result = simulation
sum = result[0] + result[1]
boys_percent = result[1]/sum.to_f*100
girls_percent = result[0]/sum.to_f*100

puts "Boys: #{boys_percent.round(2)}%"
puts "Girls: #{girls_percent.round(2)}%"
=end
