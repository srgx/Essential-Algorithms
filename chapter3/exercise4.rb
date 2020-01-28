require_relative 'exercise3.rb'
# Exercise 4

def addAtBottom(bottom,new_cell)
  insertCell(bottom.previous,new_cell)
end
