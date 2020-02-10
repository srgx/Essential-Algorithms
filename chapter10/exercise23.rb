# Exercise 23

class Literal
  attr_accessor :value
  def initialize(val)
    @value = val
  end

  def evaluate
    return @value.to_f
  end
end

class ExpressionNode
  attr_accessor :operator, :left_operand, :right_operand
  def initialize(op)
    @operator = op
  end

  def evaluate
    left = @left_operand.evaluate
    right = @right_operand.evaluate
    case @operator
    when :plus
      r = left + right
    when :minus
      r = left - right
    when :times
      r = left * right
    when :divide
      r = left / right
    end
    return r.to_f
  end
end


left = ExpressionNode.new(:divide)
left.left_operand = Literal.new(15)
left.right_operand = Literal.new(3)

right = ExpressionNode.new(:divide)
right.left_operand = Literal.new(24)
right.right_operand = Literal.new(6)

main = ExpressionNode.new(:plus)
main.left_operand = left
main.right_operand = right


raise "Error" if main.evaluate != (15 / 3) + (24 / 6) # TEST 1

left = ExpressionNode.new(:times)
left.left_operand = Literal.new(8)
left.right_operand = Literal.new(12)

right = ExpressionNode.new(:times)
right.left_operand = Literal.new(14)
right.right_operand = Literal.new(32)

main = ExpressionNode.new(:minus)
main.left_operand = left
main.right_operand = right

raise "Error" if main.evaluate != 8 * 12 - 14 * 32 # TEST 2

one = ExpressionNode.new(:divide)
one.left_operand = Literal.new(1)
one.right_operand = Literal.new(2)

two = ExpressionNode.new(:divide)
two.left_operand = Literal.new(1)
two.right_operand = Literal.new(4)

three = ExpressionNode.new(:divide)
three.left_operand = Literal.new(1)
three.right_operand = Literal.new(20)

leftSide = ExpressionNode.new(:plus)
leftSide.left_operand = one
leftSide.right_operand = two

main = ExpressionNode.new(:plus)
main.left_operand = leftSide
main.right_operand = three

raise "Error" if main.evaluate != 1.0/2 + 1.0/4 + 1.0/20 # TEST 3
