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
  def initialize(name,x,y)
    @name, @x, @y, @links = name, x, y, []
    @image = Circle.new(x: @x, y: @y, radius: 40, sectors: 32, color: 'fuchsia', z: 10)
    @text = Text.new(@name, x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def remove
    [@image,@text].each { |itm| itm.remove }
    @links.each { |lnk| lnk.remove }
  end
end

class Link
  attr_accessor :cost, :capacity, :nodes
  def initialize(startNode,targetNode,cost,capacity)
    @nodes = Array.new(2)
    @nodes[0], @nodes[1] = startNode, targetNode
    @cost, @capacity = cost, capacity
    @image = Line.new(
      x1: @nodes[0].x, y1: @nodes[0].y,
      x2: @nodes[1].x, y2: @nodes[1].y,
      width: 5, color: 'lime', z: 20
    )
  end

  def remove
    @image.remove
  end
end


class TextField
  attr_reader :text
  def initialize(text,x,y)
      @text, @x, @y = text, x, y
      Rectangle.new(x: @x, y: @y, width: 200, height: 50, color: 'orange', z: 10)
      @image = Text.new(@text,x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def enter(le)
    @image.text += le
    @text += le
  end

  def delete
    @image.text = @image.text.chop
    @text.chop!
  end
end

class Button
  attr_accessor :x, :y, :text
  def initialize(text,x,y)
      @text, @x, @y, @color = text, x, y, 'red'
      @image = Rectangle.new(x: @x, y: @y,width: 200, height: 50, color: @color, z: 10)
      Text.new(@text, x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def click
    if(@text=="New Node")
      @image.color = 'green'
      return :new
    elsif(@text=="Load Network")
      return :load
    end
  end

  def reset
    @image.color = 'red'
  end
end

class State
  attr_accessor :nodes, :mode
  def initialize
    @numNodes, @nodes, @buttons, @mode = 0, [], [], :normal
    @buttons << Button.new('New Node',100,50)
    @buttons << Button.new('Load Network',400,50)
    @input = TextField.new("test.ntw",1200,50)
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

  def key(ke)
    case ke
    when "backspace"
      @input.delete
    else
      @input.enter(ke)
    end
  end

  def load
    @nodes.each { |nd| nd.remove } # clean images before deleting nodes
    @nodes, dataSets = [], []

    # read data from file to dataSets
    File.open(@input.text, "r") do |f|
      @numNodes = f.gets.to_i
      f.each_line { |line| dataSets << line.split }
    end

    # create all nodes
    dataSets.each do |ln|
      x, y = ln[1].to_i, ln[2].to_i
      @nodes << Node.new(ln[0],x,y)
    end

    # set links
    dataSets.zip(@nodes).each do |ln, nd|

      # first 3 words are: name, x, y
      # link data groups are 3 words long(node_id, cost, capacity)
      numLinks = (ln.size-3)/3

      # 3 is index of first link in line
      index = 3
      numLinks.times do
        targetNode = @nodes[ln[index].to_i]
        cost, capacity = ln[index+1].to_i, ln[index+2].to_i
        nd.links << Link.new(nd,targetNode,cost,capacity)
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

on :key_down do |event|
  state.key(event.key)
end


show
