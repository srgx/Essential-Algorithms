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
