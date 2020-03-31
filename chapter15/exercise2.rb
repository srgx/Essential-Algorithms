# Exercise 2

def parse(expression)
  if(expression[0]!='(')
    return expression.to_i
  end

  # counter = 0
  # expression.each_char do |ch|
  #   if(ch=='(')
  #     counter += 1
  #   elsif(ch==')')
  #     counter -= 1
  #     return false if(counter < 0)
  #   end
  # end
  #
  # return (counter == 0)

end

# (5 * 2)

puts parse("12")
puts parse(" 9")
