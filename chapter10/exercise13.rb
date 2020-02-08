require_relative 'exercise11.rb'
# Exercise 13

def preorderTree(node,spaces)
  print(" " * spaces)
  puts node.name
  unless(node.leftChild.nil?) then preorderTree(node.leftChild,spaces+2) end
  unless(node.rightChild.nil?) then preorderTree(node.rightChild,spaces+2) end
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

preorderTree(root,0)
