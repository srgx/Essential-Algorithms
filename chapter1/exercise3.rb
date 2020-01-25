# Exercise 3
# For n>50 1500*n is better than 30*(n**2), for n==50 they are equal

def testFunctions
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
