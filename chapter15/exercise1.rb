# Exercise 1

def isProperlyNested(expression)
  counter = 0
  expression.each_char do |ch|
    if(ch=='(')
      counter += 1
    elsif(ch==')')
      counter -= 1
      return false if(counter < 0)
    end
  end
  return (counter == 0)
end

ER = "Error"

raise ER unless isProperlyNested("()(()(()))")
raise ER unless isProperlyNested("(8 × 3) + (20 ÷ (7 – 3))")
raise ER unless isProperlyNested("((()(al(z())z)())()t)()")
raise ER if isProperlyNested("((()(((br))))))")
raise ER if isProperlyNested("((t(()((())d)))")
