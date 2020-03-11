# Exercise 1

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080


class Node
  attr_accessor :name, :x, :y, :links
  def initialize(name)
    @name = name
    @links = []
  end

  def draw
    Circle.new(
      x: @x, y: @y,
      radius: 40,
      sectors: 32,
      color: 'fuchsia',
      z: 10
    )

    Text.new(
      @name,
      x: @x, y: @y,
      size: 20,
      color: 'blue',
      z: 10
    )

    @links.each { |lnk| lnk.draw }
  end
end

class Link
  attr_accessor :cost, :capacity, :nodes
  def initialize(startNode = nil)
    @nodes = []
    unless(startNode.nil?)
      @nodes << startNode
    end
  end

  def draw
    Line.new(
      x1: nodes[0].x, y1: nodes[0].y,
      x2: nodes[1].x, y2: nodes[1].y,
      width: 5,
      color: 'lime',
      z: 20
    )
  end
end


class Button
  attr_accessor :x, :y, :text

  def initialize(text,x,y)
      @text = text
      @x, @y = x, y
      @color = 'red'
  end

  def draw
    Rectangle.new(
      x: @x, y: @y,
      width: 200, height: 50,
      color: @color,
      z: 10
    )

    Text.new(
      @text,
      x: @x, y: @y,
      size: 20,
      color: 'blue',
      z: 10
    )
  end

  def click
    if(@text=="New Node")
      @color = 'green'
      return :new
    elsif(@text=="Load Network")
      return :load
    end
  end

  def reset
    @color = 'red'
  end
end

class State
  attr_accessor :nodes, :mode
  def initialize
    @numNodes = 0
    @nodes = []
    @mode = :normal
    @buttons = []
    @buttons << Button.new('New Node',100,50)
    @buttons << Button.new('Load Network',400,50)
  end

  def draw
    @nodes.each { |nd| nd.draw }
    @buttons.each { |btn| btn.draw }
  end

  def click(x,y)
    option = nil
    @buttons.each do |btn|
      if(x>btn.x&&x<btn.x+200&&y>btn.y&&y<btn.y+50)
        option = btn.click
        break
      end
    end

    unless(option.nil?)
      case option
      when :load
        puts "Loading file..."
        self.load
      when :new
        # @mode = :new
        puts "Adding new node..."
      end
    end
  end

  def load
    @nodes = []
    dataSets = []

    # read data from file to dataSets
    File.open("test.ntw", "r") do |f|
      @numNodes = f.gets.to_i
      f.each_line { |line| dataSets << line.split }
    end


    # create all nodes
    dataSets.each do |ln|
      node = Node.new(ln[0])
      node.x, node.y = ln[1].to_i, ln[2].to_i
      @nodes << node
    end

    # set links
    dataSets.each_with_index do |ln, i|
      currentNode = @nodes[i]

      # first 3 words are: name, x, y
      # link data groups are 3 words long(node_id, cost, capacity)
      numLinks = (ln.size-3)/3

      # 3 is index of first link in line
      index = 3
      numLinks.times do

        # add current node(start)
        link = Link.new(currentNode)
        toNodeIndex = ln[index].to_i

        # add target node(destination)
        link.nodes << nodes[toNodeIndex]
        link.cost = ln[index+1].to_i
        link.capacity = ln[index+2].to_i

        currentNode.links << link
        index += 3 # move to next link
      end
    end
  end

  def resetMode
    @mode = :normal
    @buttons.each { | btn | btn.reset }
  end

end

state = State.new

tick = 0

update do
  if tick % 60 == 0
    state.draw
  end
  tick += 1
end


on :mouse_down do |event|
  case event.button
  when :left
    state.click(event.x,event.y)
  when :middle
    #
  when :right
    state.resetMode
  end
end

show
