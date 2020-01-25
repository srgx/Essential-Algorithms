# Exercise 4
# Algorithm n/2+8 is better for all values except n(6-15)(worse) and n(4,5,16)(equal)

def testFunctions
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
