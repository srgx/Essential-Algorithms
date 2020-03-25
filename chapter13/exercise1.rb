# Exercise 1

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class Node
  attr_reader :name, :x, :y, :links, :fromNode, :color
  attr_accessor :visited, :distance, :fromLink
  @@traversal = []
  def initialize(name,x,y)
    @visited = false
    @name, @x, @y, @links = name, x, y, []
    @image = Circle.new(x: @x, y: @y, radius: 30, sectors: 32, color: 'fuchsia', z: 8)
    @text = Text.new(@name, x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def remove
    [@image,@text].each { |itm| itm.remove }
    @links.each { |lnk| lnk.remove }
  end

  def setColor(color)
    @image.color = color
  end

  def activate
    @image.color = 'green'
  end

  def deactivate
    @image.color = 'fuchsia'
  end

  def self.clearTraversals
    @@traversal.each { |t| t.remove }
    @@traversal = []
  end

  def traverse(type)
    Node.clearTraversals
    count = 1
    @@traversal << Text.new(count, x: @x, y: @y, size: 80, color: 'blue', z: 30)
    self.visit
    stack = [self]

    while(!stack.empty?)
      node = type == :depth ? stack.pop : stack.shift
      node.links.each do |ln|
        if(!ln.nodes[1].visited)
          count += 1
          @@traversal << Text.new(count, x: ln.nodes[1].x, y: ln.nodes[1].y, size: 80, color: 'blue', z: 30)
          ln.nodes[1].visit
          stack << ln.nodes[1]
        end
      end
    end
  end

  def getLinkTo(node)
    target = nil
    @links.each do |ln|
      if(ln.nodes[1]==node)
        target = ln
        break
      end
    end
    return target
  end

  def depthTraverse
    self.traverse(:depth)
  end

  def breadthTraverse
    self.traverse(:breadth)
  end

  def reset
    @visited = false
    @fromNode = @fromLink = @distance = nil
    self.deactivate
    @links.each { |ln| ln.unvisit }
  end

  def visit
    @visited = true
  end

  def visitFrom(node)
    self.visit
    @fromNode = node
  end
end

class Link
  attr_reader :cost, :capacity, :nodes, :visited
  def initialize(startNode,targetNode,cost,capacity)
    @nodes = Array.new(2)
    @nodes[0], @nodes[1] = startNode, targetNode
    @cost, @capacity = cost, capacity
    @image = Line.new(
      x1: @nodes[0].x, y1: @nodes[0].y,
      x2: @nodes[1].x, y2: @nodes[1].y,
      width: 10, color: 'brown', z: 1
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

  def visit
    @visited = true
    @image.color = 'lime'
  end

  def unvisit
    @visited = false
    @image.color = 'black'
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
      @image = Rectangle.new(x: @x, y: @y,width: 200, height: 30, color: @color, z: 10)
      Text.new(@text, x: @x, y: @y, size: 20, color: 'blue', z: 10)
  end

  def click
    if([:new,:add,:oneway,:twoway,:depthfirst,:breadthfirst,:spanningtree,:minspanningtree,:path,:labsetpath,:labcorpath,:labsettree,:labcortree].include?(@symbol))
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
    @items << Button.new('Clear All',680,20,:clearall)
    @items << Button.new('Components',900,20,:components)
    @items << Button.new('Spanning Tree',1120,20,:spanningtree)
    @items << Button.new('Min Sp Tree',1340,20,:minspanningtree)

    @items << Button.new('Add One Way Link',20,60,:oneway)
    @items << Button.new('Add Two Way Link',240,60,:twoway)
    @items << Button.new('Depth First Trav',460,60,:depthfirst)
    @items << Button.new('Breadth First Trav',680,60,:breadthfirst)
    @items << Button.new('Show Path',900,60,:path)
    @items << Button.new('LabSet Path',1120,60,:labsetpath)
    @items << Button.new('LabCor Path',1340,60,:labcorpath)

    @items << Button.new('LabSet Tree',20,100,:labsettree)
    @items << Button.new('LabCor Tree',240,100,:labcortree)

    @items << TextField.new("test3.ntw",1700,20,:filename)
    @items << TextField.new("X",1700,100,:nodename)
    @items << TextField.new("0",1700,180,:cost)
    @items << TextField.new("0",1700,260,:capacity)

    @temp = []
  end

  def getTextField(symbol)
    return @items.detect { |f| f.symbol == symbol }
  end

  def showMinSpanningTree(startNode)
    self.clearAll
    startNode.visit
    startNode.setColor('brown')
    candidates, lastAddedNode = [], startNode
    lastAddedNode.links.each { |ln| candidates << ln}

    while(!candidates.empty?)

      # find best candidate
      bestCandidate = candidates[0]
      for i in 1...candidates.size
        if(candidates[i].cost < bestCandidate.cost)
          bestCandidate = candidates[i]
        end
      end

      # add new node to spanning tree
      bestCandidate.visit # visit link

      # visit second link if exists
      secondLink = bestCandidate.nodes[1].getLinkTo(bestCandidate.nodes[0])
      secondLink&.visit

      bestCandidate.nodes[1].visit # visit node
      candidates.delete(bestCandidate)
      lastAddedNode = bestCandidate.nodes[1]

      # delete visited candidates
      candidates.select! { |cn| !cn.nodes[1].visited }

      # add links from last node
      lastAddedNode.links.each do |ln|
        if(!ln.nodes[1].visited) then candidates << ln end
      end
    end

    # reset mode, buttons, textfields
    self.resetMode
    self.resetItems
  end

  def showSpanningTree(startNode)
    self.clearAll
    stack = [startNode]
    startNode.visit
    startNode.setColor('brown')

    while(!stack.empty?)
      node = stack.pop
      node.links.each do |ln|
        if(!ln.nodes[1].visited)
          ln.visit # visit link A -> B
          secondLink = ln.nodes[1].getLinkTo(node)
          secondLink&.visit # visit link B -> A
          ln.nodes[1].visit
          stack.push(ln.nodes[1])
        end
      end
    end

    # reset mode, buttons, textfields
    self.resetMode
    self.resetItems
  end

  def showPath(fromNode,toNode)
    self.clearAll
    stack = [fromNode]
    fromNode.visit

    # create spanning tree without marking links(visit only nodes)
    while(!stack.empty?)
      node = stack.pop
      node.links.each do |ln|
        if(!ln.nodes[1].visited)
          ln.nodes[1].visitFrom(node)
          stack.push(ln.nodes[1])
        end
      end
    end

    # collect links from A to B in reverse order
    pathLinks = collectLinks(fromNode,toNode)

    # draw collected links
    self.drawPath(pathLinks)

    # mark start and end nodes
    fromNode.setColor('brown')
    toNode.setColor('brown')

    # reset mode, buttons, textfields
    self.resetMode
    self.resetItems
  end

  def labCorPath(fromNode,toNode)
    self.clearAll
    fromNode.distance = 0
    candidates, lastAddedNode = [], fromNode
    lastAddedNode.links.each { |ln| candidates << ln }

    while(!candidates.empty?)

      # select first candidate
      cand = candidates.shift

      # calculate first link total distance
      dist = cand.nodes[0].distance + cand.cost

      # add node if new distance is better than previous or if previous is nil
      newNode = cand.nodes[1]
      if(newNode.distance.nil? || dist < newNode.distance)
        newNode.fromLink, newNode.distance = cand, dist
        newNode.links.each { |ln| candidates << ln}
      end
    end

    # collect path links
    currentNode, pathLinks = toNode, []
    while(currentNode!=fromNode&&!currentNode.fromLink.nil?)
      pathLinks << currentNode.fromLink
      currentNode = currentNode.fromLink.nodes[0]
    end

    # draw path from collected links
    self.drawPath(pathLinks)

    # mark start and end nodes
    fromNode.setColor('brown')
    toNode.setColor('brown')

    # reset mode, buttons, textfields
    self.resetMode
    self.resetItems
  end

  def labCorTree(rootNode)
    self.clearAll
    rootNode.setColor('brown')
    rootNode.distance = 0
    candidates, lastAddedNode = [], rootNode

    # add all links from root to candidates
    lastAddedNode.links.each { |ln| candidates << ln }

    while(!candidates.empty?)
      cand = candidates.shift

      # calculate first link total distance
      dist = cand.nodes[0].distance + cand.cost

      # add node if new distance is better than previous or nil
      newNode = cand.nodes[1]
      if(newNode.distance.nil? || dist < newNode.distance)

        # unmark old link to B(both ways)
        oldLink = newNode.fromLink # from X to B
        unless(oldLink.nil?)
          secondOld = newNode.getLinkTo(oldLink.nodes[0]) # from B to X
          secondOld&.unvisit
          oldLink.unvisit
        end

        # visit new link(both ways)
        cand.visit # A -> B
        secondLink = newNode.getLinkTo(cand.nodes[0])
        secondLink&.visit # B -> A

        # set target node fromLink
        newNode.fromLink = cand

        # set target node new distance
        newNode.distance = dist

        # add all links from new node to candidates
        newNode.links.each { |ln| candidates << ln}
      end
    end

    # reset mode, buttons, textfields
    self.resetMode
    self.resetItems
  end

  def labSetTree(rootNode)
    self.clearAll
    rootNode.visit
    rootNode.setColor('brown')
    rootNode.distance = 0
    candidates, lastAddedNode = [], rootNode

    lastAddedNode.links.each { |ln| candidates << ln }

    while(!candidates.empty?)
      # find best candidate
      bestCandidate = candidates[0]
      for i in 1...candidates.size
        if(candidates[i].nodes[0].distance + candidates[i].cost < bestCandidate.nodes[0].distance + bestCandidate.cost)
          bestCandidate = candidates[i]
        end
      end

      # visit both links
      bestCandidate.visit
      secondLink = bestCandidate.nodes[1].getLinkTo(bestCandidate.nodes[0])
      secondLink&.visit

      # visit node
      lastAddedNode = self.visitNodeFrom(bestCandidate)
      candidates.delete(bestCandidate)

      # delete visited candidates
      candidates.select! { |cn| !cn.nodes[1].visited }

      # add links from last node
      lastAddedNode.links.each do |ln|
        if(!ln.nodes[1].visited) then candidates << ln end
      end
    end

    # reset mode, buttons, textfields
    self.resetMode
    self.resetItems
  end


  def labSetPath(fromNode,toNode)
    self.clearAll
    fromNode.visit
    fromNode.distance = 0
    candidates, lastAddedNode = [], fromNode

    lastAddedNode.links.each { |ln| candidates << ln }

    while(!candidates.empty?)
      # find best candidate
      bestCandidate = candidates[0]
      for i in 1...candidates.size
        if(candidates[i].nodes[0].distance + candidates[i].cost < bestCandidate.nodes[0].distance + bestCandidate.cost)
          bestCandidate = candidates[i]
        end
      end

      # visit node
      lastAddedNode = self.visitNodeFrom(bestCandidate)
      candidates.delete(bestCandidate)

      # delete visited candidates
      candidates.select! { |cn| !cn.nodes[1].visited }

      # add links from last node
      lastAddedNode.links.each do |ln|
        if(!ln.nodes[1].visited) then candidates << ln end
      end
    end

    # collect links from A to B in reverse order
    pathLinks = collectLinks(fromNode,toNode)

    # draw collected links
    self.drawPath(pathLinks)

    # mark start and end nodes
    fromNode.setColor('brown')
    toNode.setColor('brown')

    # reset mode, buttons, textfields
    self.resetMode
    self.resetItems
  end

  def visitNodeFrom(link)
    link.nodes[1].visitFrom(link.nodes[0])
    link.nodes[1].distance = link.nodes[0].distance + link.cost
    return link.nodes[1]
  end

  def collectLinks(fromNode,toNode)
    currentNode = toNode
    pathLinks = []
    while(currentNode!=fromNode&&!currentNode.fromNode.nil?)
      pathLinks << currentNode.fromNode.getLinkTo(currentNode)
      currentNode = currentNode.fromNode
    end
    return pathLinks
  end

  def drawPath(pathLinks)
    pathLinks.each do |pl|
      secondLink = pl.nodes[1].getLinkTo(pl.nodes[0])
      pl.visit
      secondLink&.visit
    end
  end


  def showComponents
    self.clearAll
    numVisited, components, componentIndex = 0, [], 1
    while(numVisited < @numNodes)
      startNode = nil
      @nodes.each do |nd|
        if(!nd.visited)
          startNode = nd
          break
        end
      end
      stack = [startNode]
      @componentsImages << Text.new(componentIndex, x: startNode.x, y: startNode.y, size: 80, color: 'blue', z: 30)
      startNode.visit
      numVisited += 1

      component = [startNode]
      components << component

      while(!stack.empty?)
        node = stack.pop
        node.links.each do |ln|
          if(!ln.nodes[1].visited)
            @componentsImages << Text.new(componentIndex, x: ln.nodes[1].x, y: ln.nodes[1].y, size: 80, color: 'blue', z: 30)
            ln.nodes[1].visit
            numVisited += 1
            component << ln.nodes[1]
            stack.push(ln.nodes[1])
          end
        end
      end
      componentIndex += 1
    end
  end

  def clearComponents
    @componentsImages.each { |im| im.remove }
    @componentsImages = []
  end

  def getNodeAt(x,y)
    node = nil
    @nodes.each do |nd|
      if((x-nd.x)**2 + (y-nd.y)**2 < 40**2)
        node = nd
        break
      end
    end
    return node
  end

  def getItemAt(x,y)
    item = nil
    @items.each do |itm|
      if(x>itm.x&&x<itm.x+200&&y>itm.y&&y<itm.y+50)
        self.resetItems
        item = itm
        break
      end
    end
    return item
  end

  def addLink
    co = self.getTextField(:cost).text.to_i
    cap = self.getTextField(:capacity).text.to_i
    @temp[0].links << Link.new(@temp[0],@temp[1],co,cap)
    if(@mode==:twoway)
      @temp[1].links << Link.new(@temp[1],@temp[0],co,cap)
    end
    self.resetMode
    self.resetItems
    self.resetTemp
  end

  def click(x,y)
    if(@mode==:new)
      @nodes << Node.new(self.getTextField(:nodename).text.upcase,x,y)
      @numNodes+=1
      self.resetItems
      self.resetMode
    elsif(@mode==:oneway||@mode==:twoway)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        clickedNode.activate
        @temp << clickedNode
        self.addLink if (@temp.size==2)
      end
    elsif([:depthfirst,:breadthfirst].include?(@mode))
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        self.clearAll
        if(@mode==:depthfirst)
          clickedNode.depthTraverse
        elsif(@mode==:breadthfirst)
          clickedNode.breadthTraverse
        end
        self.resetMode
        self.resetItems
      end
    elsif(@mode==:spanningtree)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        self.showSpanningTree(clickedNode)
      end
    elsif(@mode==:minspanningtree)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        self.showMinSpanningTree(clickedNode)
      end
    elsif(@mode==:path)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        clickedNode.activate
        @temp << clickedNode
        if(@temp.size==2)
          self.showPath(@temp[0],@temp[1])
        end
      end
    elsif(@mode==:labsetpath)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        clickedNode.activate
        @temp << clickedNode
        if(@temp.size==2)
          self.labSetPath(@temp[0],@temp[1])
        end
      end
    elsif(@mode==:labcorpath)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        clickedNode.activate
        @temp << clickedNode
        if(@temp.size==2)
          self.labCorPath(@temp[0],@temp[1])
        end
      end
    elsif(@mode==:labsettree)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        self.labSetTree(clickedNode)
      end
    elsif(@mode==:labcortree)
      clickedNode = self.getNodeAt(x,y)
      unless(clickedNode.nil?)
        self.labCorTree(clickedNode)
      end
    else
      option = self.getItemAt(x,y)&.click
      unless(option.nil?)
        if([:new,:oneway,:twoway, :filename,:cost,:capacity,:nodename,:depthfirst,:breadthfirst,:spanningtree,:minspanningtree,:path,:labsetpath,:labcorpath,:labsettree,:labcortree].include?(option))
          @mode = option
        elsif(option==:save)
          self.save
        elsif(option==:load)
          self.load
        elsif(option==:components)
          self.showComponents
        elsif(option==:clearall)
          self.clearAll
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


  def resetTemp
    @temp.each { |t| t.deactivate } # 2 selected nodes
    @temp = []
  end

  def resetMode
    @mode = :normal
  end

  def resetItems
    @items.each { | itm | itm.reset } # buttons and textfields
  end

  def resetNetwork
    @nodes.each { |nd| nd.reset }
  end

  def clearAll
    Node.clearTraversals # remove traversal labels
    self.clearComponents # remove component labels
    self.resetNetwork # reset nodes and links
    self.resetTemp # deactivate and remove nodes from temp array
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
    state.resetItems
    state.resetTemp
  end
end

on :key_down do |event|
  state.key(event.key)
end

show
