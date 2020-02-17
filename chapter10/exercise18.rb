require_relative 'exercise17.rb'
# Exercise 18

RADIUS = 55

class ThreadedNode
  def draw
    te = Text.new(
      @value,
      size: 25,
      color: 'blue',
      z: 15
    )
    te.x = @x - te.width/2
    te.y = @y - RADIUS/2 - te.height/2


    leftTe = @leftThread.nil? ? "--" : @leftThread.value
    rightTe = @rightThread.nil? ? "--" : @rightThread.value


    # show left thread
    lft = Text.new(
      leftTe,
      size: 25,
      color: 'blue',
      z: 15
    )
    lft.x = @x - RADIUS / 2 - lft.width/2
    lft.y = @y

    # show right thread
    rgt = Text.new(
      rightTe,
      size: 25,
      color: 'blue',
      z: 15
    )
    rgt.x = @x + RADIUS / 2 - rgt.width/2
    rgt.y = @y

    Circle.new(
      x: @x, y: @y,
      radius: RADIUS,
      sectors: 25,
      color: 'fuchsia',
      z: 10
    )
    @leftChild.draw if !@leftChild.nil?
    @rightChild.draw if !@rightChild.nil?
  end
end


root = ThreadedNode.new(5)

root.addNode(2)
root.addNode(3)
root.addNode(6)
root.addNode(1)
root.addNode(4)
root.addNode(9)
root.addNode(7)
root.addNode(8)

# root.x = 900
# root.y = 100
# root.positionSubtree
# root.draw
# root.drawLines
# show
