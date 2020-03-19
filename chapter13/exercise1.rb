# Exercise 1

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class Node
  attr_reader :name, :x, :y, :links
  attr_accessor :visited
  @@traversal = []
  def initialize(name,x,y)
    @visited = false
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

  def self.clearTrav
    @@traversal.each { |t| t.remove }
    @@traversal = []
  end

  def traverse(type)
    Node.clearTrav
    count = 1
    @@traversal << Text.new(count, x: @x, y: @y, size: 80, color: 'lime', z: 30)
    @visited = true
    stack = [self]

    while(!stack.empty?)
      node = type == :depth ? stack.pop : stack.shift
      node.links.each do |ln|
        if(!ln.nodes[1].visited)
          count += 1
          @@traversal << Text.new(count, x: ln.nodes[1].x, y: ln.nodes[1].y, size: 80, color: 'lime', z: 30)
          ln.nodes[1].visited = true
          stack << ln.nodes[1]
        end
      end
    end
  end

  def depthTraverse
    self.traverse(:depth)
  end

  def breadthTraverse
    self.traverse(:breadth)
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
    if([:new,:add,:oneway,:twoway,:depthfirst,:breadthfirst].include?(@symbol))
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
    @componentsImages = []

    @items << Button.new('New Node',20,20,:new)
    @items << Button.new('Load Network',240,20,:load)
    @items << Button.new('Save Network',460,20,:save)
    @items << Button.new('Add One Way Link',20,100,:oneway)
    @items << Button.new('Add Two Way Link',240,100,:twoway)
    @items << Button.new('Depth First Trav',460,100,:depthfirst)
    @items << Button.new('Breadth First Trav',680,100,:breadthfirst)
    @items << Button.new('Clear Trav/Comp',900,100,:cleartrav)
    @items << Button.new('Components',1120,100,:components)

    @items << TextField.new("test2.ntw",1700,20,:filename)
    @items << TextField.new("X",1700,100,:nodename)
    @items << TextField.new("0",1700,180,:cost)
    @items << TextField.new("0",1700,260,:capacity)

    @temp = []
  end

  def getTextField(symbol)
    return @items.detect { |f| f.symbol == symbol }
  end


  def showComponents
    self.clearComp
    numVisited = 0
    components = []
    if(@numNodes!=@nodes.size)
      puts "W klasie: #{@numNodes}"
      puts "Naprawde: #{@nodes.size}"
      raise "Error"
    end
    componentIndex = 1
    while(numVisited < @numNodes)
      startNode = nil
      @nodes.each do |nd|
        if(!nd.visited)
          startNode = nd
          break
        end
      end
      stack = [startNode]
      @componentsImages << Text.new(componentIndex, x: startNode.x, y: startNode.y, size: 80, color: 'lime', z: 30)
      startNode.visited = true
      numVisited += 1

      component = [startNode]
      components << component

      while(!stack.empty?)
        node = stack.pop
        node.links.each do |ln|
          if(!ln.nodes[1].visited)
            @componentsImages << Text.new(componentIndex, x: ln.nodes[1].x, y: ln.nodes[1].y, size: 80, color: 'lime', z: 30)
            ln.nodes[1].visited = true
            # ln.visited = true
            numVisited += 1
            component << ln.nodes[1]
            stack.push(ln.nodes[1])
          end
        end
      end
      componentIndex += 1
    end
  end

  def clearComp
    @componentsImages.each { |im| im.remove }
    @componentsImages = []
    @nodes.each { |nd| nd.visited = false }
  end

  def click(x,y)
    if(@mode==:new)
      @nodes << Node.new(self.getTextField(:nodename).text.upcase,x,y)
      @numNodes+=1
      self.resetMode
      return
    elsif(@mode==:oneway||@mode==:twoway)
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
          if(@mode==:twoway)
            @temp[1].links << Link.new(@temp[1],@temp[0],co,cap)
          end
          self.resetMode
        end
      end
      return
    elsif([:depthfirst,:breadthfirst].include?(@mode))
      clickedNode = nil
      @nodes.each do |nd|
        if((x-nd.x)**2 + (y-nd.y)**2 < 40**2)
          clickedNode = nd
          break
        end
      end
      unless(clickedNode.nil?)
        if(@mode==:depthfirst)
          clickedNode.depthTraverse
        elsif(@mode==:breadthfirst)
          clickedNode.breadthTraverse
        end
        self.resetMode
      end
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
        if([:new,:oneway,:twoway, :filename,:cost,:capacity,:nodename,:depthfirst,:breadthfirst].include?(option))
          @mode = option
        elsif(option==:save)
          self.save
        elsif(option==:load)
          self.load
        elsif(option==:components)
          self.showComponents
        elsif(option==:cleartrav)
          Node.clearTrav
          self.clearComp
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
    @nodes.each { |nd| nd.visited = false }
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
