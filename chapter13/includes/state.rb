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

    @items << Button.new('Max Flow',20,140,:maxflow)
    @items << Button.new('Min Cut',240,140,:mincut)

    @items << TextField.new("maxflow.ntw",1700,20,:filename)
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

  # Label-correcting path
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

  # Label-correcting tree
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

  # Label-setting tree
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

  # Label-setting path
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

  # Topological sorting
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

  # Two-color network
  def twocolor

    color1, color2, colored = 'purple', 'lime', []

    # color first node
    first_node = @nodes.first
    first_node.setColor(color1)

    # add first colored node to queue
    colored << first_node

    while(!colored.empty?)

      # choose neighbor color for node from queue
      node = colored.shift
      neighbor_color = (node.color == color1) ? color2 : color1

      # color neighbors and add them to queue
      node.links.each do |ln|
        neighbor = ln.nodes[1]
        if(neighbor.color == node.color)
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

  # Color network(hill climbing heuristic)
  def hillcolor

    colors = ['blue','red','green','purple',
              'lime','brown','silver','olive',
              'aqua','teal']

    @nodes.each do |nd|

      # find all adjacent colors
      neighbor_colors = []
      nd.links.each { |ln| neighbor_colors << ln.nodes[1].color }

      # find first correct node color
      index = 0
      while(neighbor_colors.include?(colors[index]))
        index += 1
      end
      nd.setColor(colors[index])

    end

  end


  # find node with degree less than n
  def findLess(n)
    @nodes.each do |nd|

      unless(nd.tempRemoved)
        numNeighbors = 0

        # count nonremoved neighbors
        nd.links.each do |ln|
          neighbor = ln.nodes[1]
          unless(neighbor.tempRemoved)
            numNeighbors += 1
          end
        end

        return nd if(numNeighbors<n)
      end

    end
    return nil
  end


  # index of nonremoved node
  def threeTrav(index)
    # colors - red, green, blue

    # check if solution is correct
    if(index==@nodes.size)
      allcorrect = @nodes.all? { |nd| nd.correct }
      allcolors = @nodes.any? { |nd| nd.color == 'red'} &&
                  @nodes.any? { |nd| nd.color == 'green'} &&
                  @nodes.any? { |nd| nd.color == 'blue'}
      return allcorrect && allcolors
    end


    # find index of next nonremoved node
    nextIndex = index + 1
    while(nextIndex<@nodes.size&&@nodes[nextIndex].tempRemoved)
      nextIndex += 1
    end


    # generate  and check solutions

    @nodes[index].setColor('red')

    return true if(threeTrav(nextIndex))

    @nodes[index].setColor('green')

    return true if(threeTrav(nextIndex))

    @nodes[index].setColor('blue')

    return true if(threeTrav(nextIndex))

    return false

  end

  def fourTrav(index)
    # colors - red, green, blue, purple

    # check if solution is correct
    if(index==@nodes.size)
      allcorrect = @nodes.all? { |nd| nd.correct }
      allcolors = @nodes.any? { |nd| nd.color == 'red'} &&
                  @nodes.any? { |nd| nd.color == 'green'} &&
                  @nodes.any? { |nd| nd.color == 'blue'} &&
                  @nodes.any? { |nd| nd.color == 'purple'}
      return allcorrect && allcolors
    end

    # find index of next nonremoved node
    nextIndex = index + 1
    while(nextIndex<@nodes.size&&@nodes[nextIndex].tempRemoved)
      nextIndex += 1
    end


    # generate  and check solutions

    @nodes[index].setColor('red')

    return true if(fourTrav(nextIndex))

    @nodes[index].setColor('green')

    return true if(fourTrav(nextIndex))

    @nodes[index].setColor('blue')

    return true if(fourTrav(nextIndex))

    @nodes[index].setColor('purple')

    return true if(fourTrav(nextIndex))

    return false
  end

  # Three-color network
  def threecolor

    clearAll

    # mark nodes with degree les than 3 as removed
    stackTempRemoved = []
    while(!(node=findLess(3)).nil?)
      node.tempRemove
      stackTempRemoved << node
    end

    # find index of first nonremoved node
    firstIndex = @nodes.index { |z| !z.tempRemoved }

    # if there is no solution for smaller network
    # there is no solution for whole network
    return false if(!firstIndex.nil?&&!threeTrav(firstIndex))

    colors = ['red','green','blue']

    # restore and color removed nodes
    stackTempRemoved.reverse_each do |nd|
      colorIndex = 0
      nd.restore
      nd.setColor(colors[colorIndex])

      # find first correct color
      while(!nd.correct&&colorIndex<colors.size)
        colorIndex += 1
        nd.setColor(colors[colorIndex])
      end

      # cant find color
      return false if(colorIndex>=colors.size)

    end

    return true
  end

  # Four-color network
  def fourcolor

    clearAll

    # mark nodes with degree les than 4 as removed
    stackTempRemoved = []
    while(!(node=findLess(4)).nil?)
      node.tempRemove
      stackTempRemoved << node
    end


    # find index of first nonremoved node
    firstIndex = @nodes.index { |z| !z.tempRemoved }

    # if there is no solution for smaller network
    # there is no solution for whole network
    return false if(!firstIndex.nil?&&!fourTrav(firstIndex))

    colors = ['red','green','blue','purple']

    # restore and color removed nodes
    stackTempRemoved.reverse_each do |nd|
      colorIndex = 0
      nd.restore
      nd.setColor(colors[colorIndex])

      # find first correct color
      while(!nd.correct&&colorIndex<colors.size)
        colorIndex += 1
        nd.setColor(colors[colorIndex])
      end

      # cant find color
      return false if(colorIndex>=colors.size)

    end

    return true
  end

  # Color network using fewest possible colors(exhaustive search)
  def excolor

    # twocolor.ntw - 2 colors
    # hill2.ntw - 3 colors
    # hill1.ntw - 4 colors

    if(twocolor)
      puts "Two Colors"
    elsif(threecolor)
      puts "Three Colors"
    elsif(fourcolor)
      puts "Four Colors"
    else
      puts "Impossible"
    end

  end

  # Find augmenting path
  def findAuPath(currentNode,collectedLinks)

    if(currentNode.name=='SNK')
      @nodes.each { |nd| nd.unvisit }
      return collectedLinks
    end

    currentNode.visit

    # find links with positive residual capacity
    forwardLinks = currentNode.links.select { |ln| ln.capacity-ln.cost > 0 && !ln.nodes[1].visited }
    backlinks = currentNode.backlinks.select { |ln|  ln.cost > 0 && !ln.nodes[0].visited }
    candidates = forwardLinks + backlinks

    # search for path
    candidates.each do |link|

      collectedLinks << link


      # candidate is forward link
      if(link.nodes[0]==currentNode)

        if(findAuPath(link.nodes[1],collectedLinks))
          return collectedLinks
        else
          link.nodes[1].unvisit
          collectedLinks.pop
        end

      # candidate is backlink
      elsif(link.nodes[1]==currentNode)

        if(findAuPath(link.nodes[0],collectedLinks))
          return collectedLinks
        else
          link.nodes[0].unvisit
          collectedLinks.pop
        end

      else
        raise "Error..."
      end

    end

    # unvisit nodes
    @nodes.each { |nd| nd.unvisit }

    # cant find path
    return false

  end

  # Maximal flow
  def maxflow

    clearAll

    sourceIndex = @nodes.index { |n| n.name == 'SRC' }
    sinkIndex = @nodes.index { |n| n.name == 'SNK' }

    source, sink = @nodes[sourceIndex], @nodes[sinkIndex]

    # set backlinks
    @nodes.each do |nd|
      nd.links.each do |ln|
        targetNode = ln.nodes[1]
        targetNode.addBacklink(ln)
      end
    end

    collectedLinks = []

    while(findAuPath(source,collectedLinks))

      # find minimal flow amount
      minFlow = collectedLinks[0].capacity - collectedLinks[0].cost
      lastNode = collectedLinks[0].nodes[1]

      for i in 1...collectedLinks.size

        # normal link
        if(collectedLinks[i].nodes[0] == lastNode)
          currentFlow = collectedLinks[i].capacity - collectedLinks[i].cost
          lastNode = collectedLinks[i].nodes[1]

        # backlink
        elsif(collectedLinks[i].nodes[1] == lastNode)
          currentFlow = collectedLinks[i].capacity
          lastNode = collectedLinks[i].nodes[0]

        # error
        else
          raise "Wrong link sequence"
        end

        minFlow = currentFlow if(currentFlow<minFlow)

      end


      # Update path with minimal flow amount
      lastNode = source
      for i in 0...collectedLinks.size

        # add to normal link
        if(collectedLinks[i].nodes[0] == lastNode)
          collectedLinks[i].increaseFlowBy(minFlow)
          lastNode = collectedLinks[i].nodes[1]
        # subtract from backlink
        elsif(collectedLinks[i].nodes[1] == lastNode)
          collectedLinks[i].decreaseFlowBy(minFlow)
          lastNode = collectedLinks[i].nodes[0]
        else
          raise "Wrong link sequence"
        end
      end

      # reset collected links before calling findAuPath again
      collectedLinks = []

    end

  end

  def minVisit(node)

    node.visit

    forwardLinks = node.links.select { |ln| ln.capacity-ln.cost > 0 && !ln.nodes[1].visited }
    backlinks = node.backlinks.select { |ln|  ln.cost > 0 && !ln.nodes[0].visited }
    links = forwardLinks + backlinks


    links.each do |ln|

      # forward link
      if(ln.nodes[0]==node)
        minVisit(ln.nodes[1])

      # backlink
      elsif(ln.nodes[1]==node)
        minVisit(ln.nodes[0])

      else
        raise "Error..."
      end

    end
  end

  # Minimal flow cut
  def mincut
    maxflow

    sinkIndex = @nodes.index { |n| n.name == 'SRC' }
    sink = @nodes[sinkIndex]

    minVisit(sink)

    @nodes.each do |nd|
      if(nd.visited)
        links = nd.links
        links.each do |ln|
          unless(ln.nodes[1].visited)
            ln.markRemoved
          end
        end
      end
    end

    @nodes.each { |n| n.unvisit }

  end

  def click(x,y)
    if(@mode==:new)
      @nodes << Node.new(self.getTextField(:nodename).text.upcase,x,y)
      @numNodes+=1
      self.resetItems
      self.resetMode
    else
      clickedNode = self.getNodeAt(x,y)

      if([:oneway,:twoway,:depthfirst,:breadthfirst,:spanningtree,
          :minspanningtree,:path,:labsetpath,:labcorpath,:labsettree,
          :labcortree].include?(@mode))
        unless(clickedNode.nil?)
          if([:oneway,:twoway].include?(@mode))
            clickedNode.activate
            @temp << clickedNode
            self.addLink if (@temp.size==2)
          elsif([:depthfirst,:breadthfirst].include?(@mode))
            self.clearAll
            opts = { depthfirst: :depthTraverse, breadthfirst: :breadthTraverse }
            clickedNode.send(opts[@mode])
            self.resetMode
            self.resetItems
          elsif([:spanningtree,:minspanningtree].include?(@mode))
            opts = { spanningtree: :showSpanningTree, minspanningtree: :showMinSpanningTree }
            send(opts[@mode],clickedNode)
          elsif([:path,:labsetpath,:labcorpath].include?(@mode))
            clickedNode.activate
            @temp << clickedNode
            if(@temp.size==2)
              opts = {path: :showPath, labsetpath: :labSetPath, labcorpath: :labCorPath }
              send(opts[@mode],@temp[0],@temp[1])
            end
          elsif([:labsettree,:labcortree].include?(@mode))
            opts = { labsettree: :labSetTree, labcortree: :labCorTree }
            send(opts[@mode],clickedNode)
          end
        end
      else
        option = self.getItemAt(x,y)&.click
        unless(option.nil?)
          if([ :new, :oneway, :twoway, :filename, :cost,
               :capacity, :nodename, :depthfirst,:breadthfirst,
               :spanningtree,:minspanningtree,:path,:labsetpath,
               :labcorpath,:labsettree,:labcortree].include?(option))
            @mode = option
          else
            opts = { save: :save, load: :load, components: :showComponents,
                     allpaths: :allPaths, toposort: :toposort, twocolor: :twocolor,
                     hillcolor: :hillcolor, excolor: :excolor, maxflow: :maxflow,
                     mincut: :mincut, clearall: :clearAll }

            send(opts[option])
          end
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
