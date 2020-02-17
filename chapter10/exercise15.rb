require_relative 'exercise14.rb'
# Exercise 15

class BinaryNode
  def positionSubtree
    if(@leftChild.nil?&&@rightChild.nil?)
      return
    elsif(!@leftChild.nil?&&@rightChild.nil?)
      @leftChild.x = @x - 100
      @leftChild.y = @y + 100
      @leftChild.positionSubtree
    elsif(@leftChild.nil?&&!@rightChild.nil?)
      @rightChild.x = @x + 100
      @rightChild.y = @y + 100
      @rightChild.positionSubtree
    else

      # position left subtree
      @leftChild.x = @x-100
      @leftChild.y = @y+100
      @leftChild.positionSubtree


      # move whole subtree to the left part if necessary
      leftMaxX = @leftChild.maxRight
      if(leftMaxX>=@x)
        @leftChild.moveTree(-(leftMaxX-@x+SPACE))
      end

      # position right subtree
      @rightChild.x = @x + 100
      @rightChild.y = @y + 100
      @rightChild.positionSubtree

      # move whole subtree to the right part if necessary
      rightMinX = @rightChild.maxLeft
      if(rightMinX<=@x)
        @rightChild.moveTree(@x-rightMinX+SPACE)
      end

    end
  end

  # max x value
  def maxRight
    if(@rightChild.nil?&&@leftChild.nil?)
      return @x
    elsif(!@rightChild.nil?)
      return @rightChild.maxRight
    else
      return @x+100 # space for absent child
    end
  end

  # min x value
  def maxLeft
    if(@leftChild.nil?&&@rightChild.nil?)
      return @x
    elsif(!@leftChild.nil?)
      return @leftChild.maxLeft
    else
      return @x-100 # space for absent child
    end
  end
end


root = BinaryNode.new("E")
a = BinaryNode.new("A")
b = BinaryNode.new("B")
c = BinaryNode.new("C")
d = BinaryNode.new("D")
f = BinaryNode.new("F")
g = BinaryNode.new("G")
h = BinaryNode.new("H")
i = BinaryNode.new("I")
j = BinaryNode.new("J")


# left side
root.leftChild = b
b.leftChild = a
b.rightChild = d
d.leftChild = c

# right side
root.rightChild = f
f.rightChild = i
i.rightChild = j
i.leftChild = g
g.rightChild = h

# c.leftChild = BinaryNode.new("Z")
# c.rightChild = BinaryNode.new("R")
# d.rightChild = BinaryNode.new("U")


# root.x = 900
# root.y = 100
# root.positionSubtree
# root.draw
# root.drawLines
# show
