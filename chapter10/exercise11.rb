# Exercise 11

class BinaryNode
  attr_accessor :leftChild, :rightChild, :name
  def initialize(name)
    @name = name
  end
end


def preorder(node)
  puts node.name
  unless(node.leftChild.nil?) then preorder(node.leftChild) end
  unless(node.rightChild.nil?) then preorder(node.rightChild) end
end

def inorder(node)
  unless(node.leftChild.nil?) then inorder(node.leftChild) end
  puts node.name
  unless(node.rightChild.nil?) then inorder(node.rightChild) end
end

def postorder(node)
  unless(node.leftChild.nil?) then postorder(node.leftChild) end
  unless(node.rightChild.nil?) then postorder(node.rightChild) end
  puts node.name
end

def depthfirst(node)
  queue = []
  queue.push(node)
  while(!queue.empty?)
    nd = queue.shift
    puts nd.name
    unless(nd.leftChild.nil?) then queue.push(nd.leftChild) end
    unless(nd.rightChild.nil?) then queue.push(nd.rightChild) end
  end
end


ROOT = BinaryNode.new("E")
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
ROOT.leftChild = b
b.leftChild = a
b.rightChild = d
d.leftChild = c

# right side
ROOT.rightChild = f
f.rightChild = i
i.rightChild = j
i.leftChild = g
g.rightChild = h


=begin
puts "Preorder:"
preorder(ROOT)

puts "Inorder:"
inorder(ROOT)

puts "Postorder:"
postorder(ROOT)

puts "Depthfirst:"
depthfirst(ROOT)
=end
