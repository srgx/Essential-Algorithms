require_relative 'exercise15.rb'
require_relative 'exercise16.rb'
# Exercise 17

class ThreadedNode < BinaryNode
  attr_accessor :value, :leftThread, :rightThread

  def initialize(val)
    @value = val
  end

  def addNode(new_value)
    if(new_value<@value)
      if(!@leftChild.nil?)
        @leftChild.addNode(new_value)
      else
        child = ThreadedNode.new(new_value)
        child.leftThread = @leftThread
        child.rightThread = self
        @leftChild = child
        @leftThread = nil
      end
    else
      if(!@rightChild.nil?)
        @rightChild.addNode(new_value)
      else
        child = ThreadedNode.new(new_value)
        child.leftThread = self
        child.rightThread = @rightThread
        @rightChild = child
        @rightThread = nil
      end
    end
  end
end

def inorderThread(root)
  node, viaBranch = root, true
  while(!node.nil?)

    if(viaBranch)
      while(!node.leftChild.nil?)
        node = node.leftChild
      end
    end

    puts node.value

    if(node.rightChild.nil?)
      node = node.rightThread
      viaBranch = false
    else
      node = node.rightChild
      viaBranch = true
    end

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


# inorderThread root
# puts "---"
# reverseThread root
