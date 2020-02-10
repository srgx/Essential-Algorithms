require_relative 'exercise11.rb'
# Exercise 13

def preorderTree(node,spaces)
  print(" " * spaces)
  puts node.name
  unless(node.leftChild.nil?) then preorderTree(node.leftChild,spaces+2) end
  unless(node.rightChild.nil?) then preorderTree(node.rightChild,spaces+2) end
end



# preorderTree(ROOT,0)
