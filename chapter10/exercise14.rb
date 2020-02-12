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
    #@rightChild.draw if !@rightChild.nil?
  end

  def positionSubtrees(totalWidthPixels)
    puts "Positioning children of #{@name}"


    if(!@leftChild.nil?)
      leftWidth = @leftChild.treeWidth
    else
      leftWidth = 0
    end

    if(!@rightChild.nil?)
      rightWidth = @rightChild.treeWidth
    else
      rightWidth = 0
    end

    sumSteps = leftWidth + rightWidth

    if(!@rightChild.nil?&&@leftChild.nil?)
      @rightChild.y = @y + 100
      @rightChild.x = @x
      @rightChild.positionSubtrees(totalWidthPixels)
      return
    elsif(@rightChild.nil?&&!@leftChild.nil?)
      @leftChild.y = @y + 100
      @leftChild.x = @x
      @leftChild.positionSubtrees(totalWidthPixels)
      return
    elsif(@rightChild.nil?&&@leftChild.nil?)
      return
    end


    if(@name=="B")
      puts "DEBUG"
      puts @leftChild.name
      puts @rightChild.name
    end

    if(sumSteps.zero?)
      if(!@leftChild.nil?)
        @leftChild.y = @y + 100
        @leftChild.x = @x
      end

      if(!@rightChild.nil?)
        @rightChild.y = @y + 100
        @rightChild.x = @x
      end

      return
    end

    stepSize = totalWidthPixels/sumSteps

    leftPixels = leftWidth*stepSize
    rightPixels = rightWidth*stepSize

    puts "Positioning #{@leftChild.name}"
    @leftChild.y = @y + 100
    @leftChild.x = leftPixels/2

    puts "Positioning #{@rightChild.name}"
    @rightChild.y = @y + 100
    @rightChild.x = @leftChild.x + rightPixels/2

    @leftChild.positionSubtrees(leftPixels)
    @rightChild.positionSubtrees(rightPixels)

  end

  def treeWidth
    return self.stepsLeft + self.stepsRight
  end

  def stepsRight
    if(!@rightChild.nil?&&!@leftChild.nil?)
      return 1 + @rightChild.stepsRight
    elsif(!@rightChild.nil?)
      return @rightChild.stepsRight
    elsif(!@leftChild.nil?)
      return @leftChild.stepsRight
    else
      return 0
    end
  end

  def stepsLeft
    if(!@leftChild.nil?&&!@rightChild.nil?)
      return 1 + @leftChild.stepsLeft
    elsif(!@leftChild.nil?)
      return @leftChild.stepsLeft
    elsif(!@rightChild.nil?)
      @rightChild.stepsLeft
    else
      return 0
    end
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

ROOT.x = 600
ROOT.y = 100
ROOT.positionSubtrees(900)

#ROOT.draw
#show
