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
    @items << Button.new('Log All Paths',460,100,:allpaths)
    @items << Button.new('Log Top Sort',680,100,:toposort)
    @items << Button.new('Two Color',900,100,:twocolor)
    @items << Button.new('Hill Color',1120,100,:hillcolor)
    @items << Button.new('Ex Color',1340,100,:excolor)

    @items << TextField.new("hill1.ntw",1700,20,:filename)
    @items << TextField.new("X",1700,100,:nodename)
    @items << TextField.new("0",1700,180,:cost)
    @items << TextField.new("0",1700,260,:capacity)

    @temp = []
  end

  def getTextField(symbol)
    return @items.detect { |f| f.symbol == symbol }
  end

  def allPaths
    distances = []

    # fill diagonal
    for i in 0...@numNodes
      row = []
      for j in 0...@numNodes
        row << (i==j ? 0 : Float::INFINITY)
      end
      distances << row
    end

    # fill distances to closest vertices
    for i in 0...@numNodes
      @nodes[i].links.each do |ln|
        index = @nodes.index(ln.nodes[1])
        distances[i][index] = ln.cost
      end
    end

    via = []

    # obvious best via vertices
    for i in 0...@numNodes
      row = []
      for j in 0...@numNodes
        row << (distances[i][j] < Float::INFINITY ? j : -1)
      end
      via << row
    end

    # find improvements
    for viaNode in 0...@numNodes
      for fromNode in 0...@numNodes
        for toNode in 0...@numNodes
          newDist = distances[fromNode][viaNode] + distances[viaNode][toNode]
          if(newDist < distances[fromNode][toNode])
            distances[fromNode][toNode] = newDist
            via[fromNode][toNode] = viaNode
          end
        end
      end
    end

    # log nodes
    fileContent = "Nodes\n"
    for i in 0...@numNodes
      fileContent += @nodes[i].name + " #{i}\n"
    end


    # log distances array
    fileContent += "\nDistances\n"
    distances.each do |row|
      for i in 0...@numNodes
        fileContent += row[i].to_s
        unless(i==@numNodes-1)
          fileContent += " "
        end
      end
      fileContent += "\n"
    end

    # log via array
    fileContent += "\nVia\n"
    via.each do |row|
      for i in 0...row.size
        fileContent += row[i].to_s
        unless(i==row.size-1)
          fileContent += " "
        end
      end
      fileContent += "\n"
    end

    # log all shortest paths
    fileContent += "\nAll Shortest Paths\n"
    for i in 0...@numNodes
      for j in 0...@numNodes
        if(j!=i&&distances[i][j]!=Float::INFINITY)
          s, f = @nodes[i], @nodes[j]
          path = self.findPath(s,f,via,distances)
          fileContent += "#{s.name} -> #{f.name}: #{s.name} "
          for k in 0...path.size
            fileContent += "#{path[k].name}"
            if(k!=path.size-1)
              fileContent += " "
            end
          end
          fileContent += "\n"
        end
      end
    end

    File.write('ViaDistances',fileContent)
  end

  def findPath(startNode,endNode,via,distances)
    if(distances[@nodes.index(startNode)][@nodes.index(endNode)]==Float::INFINITY)
      return []
    end

    viaNode = @nodes[via[@nodes.index(startNode)][@nodes.index(endNode)]]

    if(viaNode==endNode)
      return [endNode]
    else
      return findPath(startNode,viaNode,via,distances) +
             findPath(viaNode,endNode,via,distances)
    end
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

  def toposort
    ordering, ready = [], []

    # set number of prerequisities for each node
    @nodes.each { |nd| nd.initNumBefore }

    # set from nodes for each node
    @nodes.each do |nd|
      nd.links.each do |ln|
        ln.nodes[1].fromNodes << ln.nodes[0]
      end
    end

    # add nodes with no prerequisities to ready array
    @nodes.each do |nd|
      if(nd.numBeforeMe.zero?)
        ready << nd
      end
    end


    while(!ready.empty?)

      # move ready node to ordering
      ready_node = ready.shift
      ordering << ready_node.name

      # decrease number of prerequisities for fromnodes
      ready_node.fromNodes.each do | fn |
        fn.numBeforeMe = fn.numBeforeMe - 1

        # add to ready array if number of prerequisities is zero
        if(fn.numBeforeMe.zero?)
          ready << fn
        end
      end
    end


    if(@nodes.any?{ |nd| nd.numBeforeMe > 0 })
      return nil
    else
      fileContent = "Topological Sorting\n\n"
      ordering.each_with_index do |task,index|
        i = index + 1
        fileContent += i.to_s + ". " + task + "\n"
      end

      File.write('TopoOrder',fileContent)

      return ordering
    end

  end

  def twocolor

    clearAll

    color1, color2 = 'purple','lime'
    colored = []
    first_node = @nodes.first
    first_node.setColor(color1)
    colored << first_node

    while(!colored.empty?)
      node = colored.shift
      neighbor_color = (node.color == color1) ? color2 : color1

      node.links.each do |ln|
        neighbor = ln.nodes[1]
        if(neighbor.color == node.color)
          # clearAll
          return false
        elsif(neighbor.color == neighbor_color)
          # do nothing
        else
          neighbor.setColor(neighbor_color)
          colored << neighbor
        end
      end

    end

    return true
  end

  def hillcolor
    colors = ['blue','red','green','purple','lime','brown','silver','olive','aqua','teal']

    @nodes.each do |nd|
      neighbor_colors = []
      nd.links.each { |ln| neighbor_colors << ln.nodes[1].color }
      index = 0
      while(neighbor_colors.include?(colors[index]))
        index += 1
      end
      nd.setColor(colors[index])
    end

  end


  def findLess(n)
    @nodes.each do |nd|
      if(nd.links.size<n&&!nd.tempRemoved)
        return nd
      end
    end
    return nil
  end


  # index of nonremoved node
  def threeTrav(index)
    # red green blue

    if(index==@nodes.size) then return true end

    nextIndex = index + 1
    while(nextIndex<@nodes.size&&@nodes[nextIndex].tempRemoved)
      nextIndex += 1
    end

    @nodes[index].setColor('red')

    if(@nodes[index].correct)
      if(threeTrav(nextIndex))
        return true
      end
    end

    @nodes[index].setColor('green')

    if(@nodes[index].correct)
      if(threeTrav(nextIndex))
        return true
      end
    end

    @nodes[index].setColor('blue')

    if(@nodes[index].correct)
      if(threeTrav(nextIndex))
        return true
      end
    end

    return false
  end

  # index of nonremoved node
  def fourTrav(index)
    # red green blue purple

    if(index==@nodes.size) then return true end

    nextIndex = index + 1
    # while(nextIndex<@nodes.size&&@nodes[nextIndex].tempRemoved)
    #   nextIndex += 1
    # end

    @nodes[index].setColor('red')

    if(@nodes[index].correct)
      if(fourTrav(nextIndex))
        return true
      end
    end

    @nodes[index].setColor('green')

    if(@nodes[index].correct)
      if(fourTrav(nextIndex))
        return true
      end
    end

    @nodes[index].setColor('blue')

    if(@nodes[index].correct)
      if(fourTrav(nextIndex))
        return true
      end
    end

    @nodes[index].setColor('purple')

    if(@nodes[index].correct)
      if(fourTrav(nextIndex))
        return true
      end
    end

    return false
  end

  def threecolor
    self.clearAll
    stackTempRemoved = []
    while(!(node=findLess(3)).nil?)
      node.tempRemove
      stackTempRemoved << node
    end

    # find index of first nonremoved node
    firstIndex = @nodes.index { |z| !z.tempRemoved }

    unless(firstIndex.nil?)
      unless(threeTrav(firstIndex))
        return false
      end
    end

    unless(threeTrav(firstIndex))
      return false
    end

    colors = ['red','green','blue']

    stackTempRemoved.reverse_each do |nd|
      colorIndex = 0
      nd.restore
      nd.setColor(colors[colorIndex])

      # find first correct color
      while(!nd.correct&&colorIndex<colors.size)
        colorIndex += 1
        nd.setColor(colors[colorIndex])
      end

      if(colorIndex>=colors.size)
        puts "Impossible"
        return false
      end

    end

    return true
  end

  def fourcolor
    self.clearAll
    stackTempRemoved = []
    while(!(node=findLess(4)).nil?)
      node.tempRemove
      stackTempRemoved << node
    end

    # find index of first nonremoved node
    firstIndex = @nodes.index { |z| !z.tempRemoved }

    unless(firstIndex.nil?)
      unless(fourTrav(firstIndex))
        return false
      end
    end

    colors = ['red','green','blue','purple']

    stackTempRemoved.reverse_each do |nd|
      colorIndex = 0
      nd.restore
      nd.setColor(colors[colorIndex])

      # find first correct color
      while(!nd.correct&&colorIndex<colors.size)
        colorIndex += 1
        nd.setColor(colors[colorIndex])
      end

      if(colorIndex>=colors.size)
        puts "Impossible"
        return false
      end

    end

    puts "Koniec"
    return true
  end

  def excolor

    # if(twocolor)
    #   puts "Na Dwa"
    # elsif(threecolor)
    #   puts "Na Trzy"
    # elsif(fourcolor)
    #   puts "Na Cztery"
    # else
    #   puts "Nonplanar Network"
    # end


    # fourcolor

    fourTrav(0)
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
        elsif(option==:allpaths)
          self.allPaths
        elsif(option==:toposort)
          self.toposort
        elsif(option==:twocolor)
          self.twocolor
        elsif(option==:hillcolor)
          self.hillcolor
        elsif(option==:excolor)
          self.excolor
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

    self.resetMode
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
