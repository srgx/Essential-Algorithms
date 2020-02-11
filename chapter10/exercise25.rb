require_relative 'exercise23.rb'
# Exercise 25

DEG = 0.0174532925 # rad in deg

class MonoExpressionNode
  attr_reader :operator
  attr_writer :operand

  def initialize(op)
    @operator = op
  end

  def evaluate
    opr = @operand.evaluate
    case @operator
    when :sqrt
      r = Math.sqrt(opr)
    when :fact
      r = Math.gamma(opr + 1)
    when :squared
      r = opr**2
    when :sine
      r = Math.sin(opr * DEG)
    end
    return r
  end
end

left = ExpressionNode.new(:times)
left.left_operand = Literal.new(36)
left.right_operand = Literal.new(2)

right = ExpressionNode.new(:times)
right.left_operand = Literal.new(9)
right.right_operand = Literal.new(32)

main = ExpressionNode.new(:divide)
main.left_operand = left
main.right_operand = right

final = MonoExpressionNode.new(:sqrt)
final.operand = main

raise "Error" if final.evaluate != Math.sqrt((36*2.0)/(9*32))

fac1 = MonoExpressionNode.new(:fact)
fac1.operand = Literal.new(5)

sub = ExpressionNode.new(:minus)
sub.left_operand = Literal.new(5)
sub.right_operand = Literal.new(3)

fac2 = MonoExpressionNode.new(:fact)
fac2.operand = sub

fac3 = MonoExpressionNode.new(:fact)
fac3.operand = Literal.new(3)

right = ExpressionNode.new(:times)
right.left_operand = fac2
right.right_operand = fac3

main = ExpressionNode.new(:divide)
main.left_operand = fac1
main.right_operand = right

raise "Error" if main.evaluate != 120.0 / (2 * 6)

si = MonoExpressionNode.new(:sine)
si.operand = Literal.new(45)

main = MonoExpressionNode.new(:squared)
main.operand = si

raise "Error" if main.evaluate != (Math.sin(45*DEG))**2
