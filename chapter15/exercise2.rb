# Exercise 2

# exp is one of
# - literal
# - (exp)
# - exp op exp
# - fun(exp)

# op is one of
# - '+'
# - '-'
# - '*'
# - '/'

# fun is one of
# - 'sin'
# - 'cos'


# environment(env) is list of pairs [symbol,value]
# example: [['A',12],['B',25],['C',17]]


class Literal
  def initialize(val)
    @val = val
  end

  def evaluate(env = nil)
    if(@val=='T'||@val=='F')
      return @val
    elsif(!(var=env&.find{|v|v[0]==@val}).nil?)
      return var[1]
    else
      return @val.to_f
    end
  end
end

class Unary
  def initialize(op,exp)
    @op, @exp = op, exp
  end

  def evaluate(env=nil)
    ev = @exp.evaluate(env)
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

  def evaluate(env=nil)
    le = @left.evaluate(env)
    ri = @right.evaluate(env)
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

  # look for binary expression
  counter = 0
  for i in 0...str.size
    if(str[i]=='(')
      counter += 1
    elsif(str[i]==')')
      counter -= 1
    elsif(counter.zero?&&SYMBOLS.include?(str[i])&&i!=0) # op found, str is binary expression
      left = parse(str[0,i])
      right = parse(str[i+1..])
      return Binary.new(left,right,str[i])
    end
  end

  # if binary expression was not found look for
  # (expression), symbol, function or literal at the beginning
  if(str[0]=='(')
    parse(str[1..-2])
  elsif(str.start_with?(*FUNCTIONS))
    index = str.index('(')
    return Unary.new(str[0...index],parse(str[index..]))
  elsif(SYMBOLS.include?(str[0]))
    return Unary.new(str[0],parse(str[1..]))
  else
    return Literal.new(str)
  end

end

ER = "Error"

raise ER if parse("(5*((4+8)/2))-(20-(3*5))").evaluate!=25
raise ER if parse("7.55").evaluate!=7.55
raise ER if parse("-(2*4)*5").evaluate!=-40
raise ER if parse("7.55 + 2.15").evaluate!=9.7
raise ER if parse("(3*5)/(12/2)").evaluate!=2.5
raise ER if parse("-(6*12)").evaluate!=-72
raise ER if parse("7*-2").evaluate!=-14
re = parse("(2*3)+sin(4*5)").evaluate
er = parse("sin(4*5)+(2*3)").evaluate
raise ER if(re!=er)
raise ER if(re<6.9||re>6.92)
raise ER if(parse("-2").class!=Unary)
raise ER if(parse("-2+7").class!=Binary)
