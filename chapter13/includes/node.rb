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
