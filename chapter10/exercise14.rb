# Exercise 14

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class Node
  attr_accessor :leftChild, :rightChild, :x, :y
  def initialize(value)
    @value = value
  end

  def draw
    te = Text.new(
      @value,
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
    # @leftChild.draw(x,y+150) if !@leftChild.nil?
  end

  def treeWidth
    
  end

end

=begin
def connectNodes(node1,node2)
  Line.new(
    x1: node1.x, y1: node1.y,
    x2: node2.x, y2: node2.y,
    width: 5,
    color: 'lime',
    z: 5
  )
end
=end

top = Node.new("Top",900,100)
left = Node.new("Left")
right = Node.new("Right")

top.leftChild = left
top.rightChild = right

top.draw


show
