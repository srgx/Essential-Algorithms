# Exercise 1

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080


Square.new(
  x: 600, y: 200,
  size: 125,
  color: 'red',
  z: 10
)

Text.new(
  'Load',
  x: 150, y: 470,
  # font: 'vera.ttf',
  size: 20,
  color: 'blue',
  # rotate: 90,
  z: 10
)

Text.new(
  'Save',
  x: 450, y: 470,
  # font: 'vera.ttf',
  size: 20,
  color: 'blue',
  # rotate: 90,
  z: 10
)

class Node
  attr_accessor :name, :x, :y, :links
  def initialize(name)
    @name = name
    @links = []
  end
end

class Link
  attr_accessor :cost, :capacity, :nodes
  def initialize
    @nodes = []
  end
end

numNodes = nil
nodes = []
lines = []

File.open("test.ntw", "r") do |f|
  numNodes = f.gets.to_i
  f.each_line do |line|
    data = line.split
    lines << data
    node = Node.new(data[0])
    node.x, node.y = data[1].to_i, data[2].to_i
    nodes << node
  end
end


for i in 0...numNodes
  numLinks = (lines[i].size-3)/3

  # add links to node
  index = 3 # 3 is index of first link in line
  numLinks.times do
    link = Link.new
    link.nodes << nodes[i] # add current node(start)
    toNodeIndex = lines[i][index].to_i
    link.nodes << nodes[toNodeIndex] # add target node(destination)
    link.cost = lines[i][index+1].to_i
    link.capacity = lines[i][index+2].to_i
    nodes[i].links << link
    index += 3 # move to next link
  end
end


p nodes[0].links





# show
