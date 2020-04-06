require_relative 'exercise2.rb'
# Exercise 5

# bexp is one of
# (bexp)
# bool
# op
# '-' (NOT)

# bool is one of
# - 'T' (TRUE)
# - 'F' (FALSE)

# op is one of
# - '&' (AND)
# - '|' (OR)

class Unary
  def evaluate
    ev = @exp.evaluate
    if(@op=='-')
      return (ev=='T') ? 'F' : 'T'
    end
  end
end

class Binary
  def evaluate
    le = @left.evaluate
    ri = @right.evaluate
    case @op
    when '&'
      return (le=='F') ? le : ri
    when '|'
      return (le=='T') ? le : ri
    end
  end
end

OPS = ['&','|']

def parseBool(str)

  # look for binary expression
  counter = 0
  for i in 0...str.size
    if(str[i]=='(')
      counter += 1
    elsif(str[i]==')')
      counter -= 1
    elsif(counter.zero?&&OPS.include?(str[i])) # binary operator found
      left = parseBool(str[0,i])
      right = parseBool(str[i+1..])
      return Binary.new(left,right,str[i])
    end
  end

  # parse bool expression, unary expression or return literal
  if(str[0]=='(')
    parseBool(str[1..-2])
  elsif(str.start_with?('-'))
    return Unary.new(str[0],parseBool(str[1..]))
  else
    return Literal.new(str[0])
  end

end


raise ER if parseBool("F").evaluate != 'F'
raise ER if parseBool("T").evaluate != 'T'
raise ER if parseBool("-T").evaluate != 'F'
raise ER if parseBool("-F").evaluate != 'T'
raise ER if parseBool("T|-F").evaluate != 'T'
raise ER if parseBool("T&-F").evaluate != 'T'
raise ER if parseBool("(F|T)&(-F|-T)").evaluate != 'T'
raise ER if parseBool("(F|T)&(-T|-T)").evaluate != 'F'
raise ER if parseBool("(F&T)|(T&-F)").evaluate != 'T'
raise ER if parseBool("-(T&T)|-(T&-F)").evaluate != 'F'
