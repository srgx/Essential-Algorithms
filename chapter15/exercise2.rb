# Exercise 2

# exp is one of
# - literal
# - (exp)
# - exp op exp

# op is one of
# - '+'
# - '-'
# - '*'
# - '/'


class Literal
  def initialize(val)
    @val = val
  end

  def evaluate
    return @val
  end
end

class Unary
  def initialize(op,exp)
    @op, @exp = op, exp
  end

  def evaluate
    ev = @exp.evaluate
    case @op
    when '-'
      return -ev
    when 'sin'
      return Math.sin(ev)
    when 'cos'
      return Math.cos(ev)
    end
  end
end

class Binary
  def initialize(left,right,op)
    @left,@right,@op = left,right,op
  end

  def evaluate
    le = @left.evaluate
    ri = @right.evaluate
    case @op
    when '+'
      re = le + ri
    when '-'
      re = le - ri
    when '*'
      re = le * ri
    when '/'
      re = le / ri
    end
    return re
  end

end

SYMBOLS = ['+','-','*','/']
FUNCTIONS = ['sin','cos']

def parse(str)

  # look for unary expression
  if(SYMBOLS.include?(str[0]))
    return Unary.new(str[0],parse(str[1..]))
  elsif(str.start_with?(*FUNCTIONS))
    index = str.index('(')
    return Unary.new(str[0...index],parse(str[index..]))
  end

  # look for binary expression
  counter = 0
  for i in 0...str.size
    if(str[i]=='(')
      counter += 1
    elsif(str[i]==')')
      counter -= 1
    elsif(counter.zero?&&SYMBOLS.include?(str[i])) # op found, str is binary expression
      left = parse(str[0,i])
      right = parse(str[i+1..])
      return Binary.new(left,right,str[i])
    end
  end

  # look for expression or literal
  if(str[0]=='(')
    return parse(str[1..-2]) # parse (expr) without parentheses
  else
    return Literal.new(str.to_f) # return literal
  end

end

ER = "Error"

raise ER if parse("(5*((4+8)/2))-(20-(3*5))").evaluate!=25
raise ER if parse("7.55").evaluate!=7.55
raise ER if parse("7.55 + 2.15").evaluate!=9.7
raise ER if parse("(3*5)/(12/2)").evaluate!=2.5
raise ER if parse("-(6*12)").evaluate!=-72
raise ER if parse("7*-2").evaluate!=-14
re = parse("(2*3)+sin(4*5)").evaluate
raise ER if(re<6.9||re>6.92)
