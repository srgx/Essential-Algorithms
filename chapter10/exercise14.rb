require_relative 'exercise11.rb'
# Exercise 14

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class BinaryNode
  attr_accessor :leftChild, :rightChild, :x, :y

  def draw
    te = Text.new(
      @name,
      size: 25,
      color: 'blue',
      z: 15
    )
    te.x = @x - te.width/2
    te.y = @y - te.height/2
    Circle.new(
      x: @x, y: @y,
      radius: 45,
      sectors: 25,
      color: 'fuchsia',
      z: 10
    )
    @leftChild.draw if !@leftChild.nil?
    @rightChild.draw if !@rightChild.nil?
  end

  def drawLines
    if(!@leftChild.nil?)
      self.connectTo(@leftChild)
      @leftChild.drawLines
    end

    if(!@rightChild.nil?)
      self.connectTo(@rightChild)
      @rightChild.drawLines
    end
  end

  def positionSubtree
    if(@leftChild.nil?&&@rightChild.nil?)
      return
    elsif(!@leftChild.nil?&&@rightChild.nil?)
      @leftChild.x = @x
      @leftChild.y = @y + 100
      @leftChild.positionSubtree
    elsif(@leftChild.nil?&&!@rightChild.nil?)
      @rightChild.x = @x
      @rightChild.y = @y + 100
      @rightChild.positionSubtree
    else
      @leftChild.x = @x-100
      @leftChild.y = @y+100
      @leftChild.positionSubtree

      leftMaxX = @leftChild.maxRight

      if(leftMaxX>=@x)
        @leftChild.moveTree(-(leftMaxX-@leftChild.x))
      end

      @rightChild.x = @x + 100
      @rightChild.y = @y + 100
      @rightChild.positionSubtree

      rightMinX = @rightChild.maxLeft
      if(rightMinX<=@x)
        @rightChild.moveTree(@rightChild.x - rightMinX)
      end

    end
  end

  def maxRight
    if(@rightChild.nil?&&@leftChild.nil?)
      return @x
    elsif(!@rightChild.nil?)
      return @rightChild.maxRight
    else
      return @leftChild.maxRight
    end
  end

  def maxLeft
    if(@leftChild.nil?&&@rightChild.nil?)
      return @x
    elsif(!@leftChild.nil?)
      return @leftChild.maxLeft
    else
      return @rightChild.maxLeft
    end
  end

  def treeWidth
    return self.maxRight - self.maxLeft
  end

  def moveTree(x)
    @x += x
    if(!@leftChild.nil?) then @leftChild.moveTree(x) end
    if(!@rightChild.nil?) then @rightChild.moveTree(x) end
  end

  def connectTo(node)
    Line.new(
      x1: @x, y1: @y,
      x2: node.x, y2: node.y,
      width: 5,
      color: 'lime',
      z: 5
    )
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

=begin
root.x = 900
root.y = 100
root.positionSubtree
root.draw
root.drawLines
show
=end
