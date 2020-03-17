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
  attr_reader :cost, :capacity, :nodes
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
  attr_reader :text, :symbol, :x, :y
  def initialize(text,x,y,symbol)
      @symbol = symbol
      @text, @x, @y = text, x, y
      @image = Rectangle.new(x: @x, y: @y, width: 200, height: 50, color: 'orange', z: 10)
      @textImage = Text.new(@text,x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def enter(le)
    @textImage.text += le
    @text += le
  end

  def delete
    @textImage.text = @textImage.text.chop
    @text.chop!
  end

  def click
    @image.color = 'green'
    return @symbol
  end

  def reset
    @image.color = 'orange'
  end

end

class Button
  attr_accessor :x, :y, :text, :symbol
  def initialize(text,x,y,symbol)
      @symbol = symbol
      @text, @x, @y, @color = text, x, y, 'red'
      @image = Rectangle.new(x: @x, y: @y,width: 200, height: 50, color: @color, z: 10)
      Text.new(@text, x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def click
    if([:new,:add,:oneway].include?(@symbol))
      @image.color='green'
    end
    return @symbol
  end

  def reset
    @image.color = 'red'
  end
end

class State
  attr_accessor :nodes, :mode
  def initialize
    @numNodes, @nodes, @items, @mode = 0, [], [], :normal

    @items << Button.new('New Node',20,20,:new)
    @items << Button.new('Load Network',240,20,:load)
    @items << Button.new('Save Network',460,20,:save)
    @items << Button.new('Add One Way Link',20,100,:oneway)

    @items << TextField.new("test.ntw",1700,20,:filename)
    @items << TextField.new("X",1700,100,:nodename)
    @items << TextField.new("0",1700,180,:cost)
    @items << TextField.new("0",1700,260,:capacity)

    @temp = []
  end

  def getTextField(symbol)
    return @items.detect { |f| f.symbol == symbol }
  end

  def click(x,y)

    if(@mode==:new)
      @nodes << Node.new(self.getTextField(:nodename).text.upcase,x,y)
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
          co = self.getTextField(:cost).text.to_i
          cap = self.getTextField(:capacity).text.to_i
          @temp[0].links << Link.new(@temp[0],@temp[1],co,cap)
          self.resetMode
        end
      end
      return
    else
      option = nil
      @items.each do |itm|
        if(x>itm.x&&x<itm.x+200&&y>itm.y&&y<itm.y+50)
          @items.each {|itm| itm.reset}
          option = itm.click
          break
        end
      end

      unless(option.nil?)
        if([:new,:oneway,:filename,:cost,:capacity,:nodename].include?(option))
          @mode = option
        elsif(option==:save)
          self.save
        elsif(option==:load)
          self.load
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
        ln.show
        content += "#{@nodes.index(ln.nodes[1])} #{ln.cost} #{ln.capacity}"
        if(indx!=nd.links.size-1) then content += " " end
      end
      content += "\n"
    end
    File.write(self.getTextField(:filename).text, content)
  end

  def key(ke)
    if([:filename,:cost,:capacity,:nodename].include?(@mode))
      field = self.getTextField(@mode)
      if(ke=="backspace")
        field.delete
      else
        field.enter(ke)
      end
    end
  end

  def load
    @nodes.each { |nd| nd.remove } # clear images before deleting nodes
    @nodes, dataSets = [], []

    # read data from file to dataSets
    File.open(self.getTextField(:filename).text, "r") do |f|
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
    @items.each { | btn | btn.reset }
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
