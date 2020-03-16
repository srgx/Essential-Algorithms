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
    @image = Circle.new(x: @x, y: @y, radius: 40, sectors: 32, color: 'fuchsia', z: 8)
    @text = Text.new(@name, x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def remove
    [@image,@text].each { |itm| itm.remove }
    @links.each { |lnk| lnk.remove }
  end

  def activate
    @image.color = 'green'
  end

  def deactivate
    @image.color = 'fuchsia'
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
      width: 5, color: 'lime', z: 8
    )

    midX = (@image.x1 + @image.x2)/2.0
    midY = (@image.y1 + @image.y2)/2.0

    midX = (@image.x1 + midX)/2.0
    midY = (@image.y1 + midY)/2.0


    @text = Text.new(@cost, x: midX, y: midY, size: 20, color: 'blue', z: 10)
  end

  def remove
    @image.remove
    @text.remove
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
    elsif(@text=="Save Network")
      return :save
    elsif(@text=="Add One Way Link")
      @image.color = 'green'
      return :oneway
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
    @buttons << Button.new('Save Network',700,50)
    @buttons << Button.new('Add One Way Link',100,150)
    @input = TextField.new("test.ntw",1200,50)
    @temp = []
  end

  def click(x,y)

    if(@mode==:new)
      @nodes << Node.new("X",x,y)
      self.resetMode
      return
    elsif(@mode==:oneway)
      clickedNode = nil
      @nodes.each do |nd|
        if((x-nd.x)**2 + (y-nd.y)**2 < 40**2)
          clickedNode = nd
          break
        end
      end
      unless(clickedNode.nil?)
        clickedNode.activate
        @temp << clickedNode
        if(@temp.size==2)
          @temp[0].links << Link.new(@temp[0],@temp[1],1,1)
          self.resetMode
        end
      end
      return
    else
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
          @mode = :new
          puts "Adding new node..."
        when :save
          puts "Saving Network..."
          self.save
        when :oneway
          puts "One Way..."
          @mode = :oneway
        end
      end
    end

  end

  def save
    content = "#{@nodes.size}\n"
    nodes.each do |nd|
      content += "#{nd.name} #{nd.x} #{nd.y}"
      unless(nd.links.empty?) then content += " " end
      nd.links.each_with_index do |ln,indx|
        content += "#{@nodes.index(ln.nodes[1])} #{ln.cost} #{ln.capacity}"
        if(indx!=nd.links.size-1) then content += " " end
      end
      content += "\n"
    end
    File.write(@input.text, content)
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
    @nodes.each { |nd| nd.remove } # clear images before deleting nodes
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
    @temp.each { |t| t.deactivate }
    @temp = []
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
