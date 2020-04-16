# Exercise 17

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080



# type is one of [:add, :remove, :nochange]
class Change
  attr_reader :letter, :type
  def initialize(letter,type)
    @letter, @type = letter, type
  end

  def show
    puts "#{@type} #{@letter}"
  end
end


# fromDirection is one of [:top, :left, :diag]
class Node
  attr_reader :fromDirection, :distance, :diag
  def initialize
    @diag = false
  end

  def setDistance(dist)
    @distance = dist
  end

  def isFrom(from)
    @fromDirection = from
  end

  def setDiag
    @diag = true
  end
end

# create nodes, set top row and left column distances and links,
# set diagonal links
def createNodes(first,second)
  height, width, nodes = second.size + 1, first.size + 1, []

  for i in 0...height
    row = []
    for j in 0...width
      row << Node.new
      if(i.zero?)
        # top row
        row[j].setDistance(j)
        if(j>0) then row[j].isFrom(:left) end
      elsif(j.zero?)
        # left column
        row[j].setDistance(i)
        row[j].isFrom(:top)
      end

      # diagonal
      if(second[i]==first[j]&&i<height-1&&j<width-1)
        # there is diagonal link from
        # row[i][j] to row[i+1][j+1]
        row[j].setDiag
      end

    end
    nodes << row
  end

  return nodes
end

# set best distances for all remaining nodes
def setDistances(first,second,nodes)
  for i in 1..second.size
    for j in 1..first.size

      currentNode = nodes[i][j]
      topNode = nodes[i-1][j]
      leftNode = nodes[i][j-1]
      diagNode = nodes[i-1][j-1]

      # read all possible distances
      fromLeft = leftNode.distance + 1
      fromTop = topNode.distance + 1
      fromDiag = diagNode.diag ? diagNode.distance : Float::INFINITY

      # find best distance
      best = [fromLeft,fromTop,fromDiag].min

      # set best distance(left, top, diagonal)
      currentNode.setDistance(best)

      # set source node
      if(best==fromLeft)
        currentNode.isFrom(:left)
      elsif(best==fromTop)
        currentNode.isFrom(:top)
      else
        currentNode.isFrom(:diag)
      end

    end
  end
end


def getTotalDistance(nodes)
  return nodes.last.last.distance
end


def getChanges(first,second,nodes)

  current, changes = nodes.last.last, []

  # position in array, lower right corner
  position = [second.size,first.size]

  # read changes from end to start
  while(!current.fromDirection.nil?)
    case current.fromDirection
    when :top
      changes << Change.new(second[position[0]-1],:add)
      position[0] -= 1
    when :left
      changes << Change.new(first[position[1]-1],:remove)
      position[1] -= 1
    when :diag
      changes << Change.new(second[position[0]-1],:nochange)
      position[0] -= 1
      position[1] -= 1
    end

    current = nodes[position[0]][position[1]]
  end

  return changes.reverse
end

def displayEdits(changes,fontSize,space)
  currentX = 100

  changes.each do |chng|

    case chng.type
    when :add
      clr = 'green'
    when :remove
      clr = 'red'
    when :nochange
      clr = 'black'
    end

    Text.new(
      chng.letter,
      x: currentX, y: 250,
      font: 'CamingoCode-Regular.ttf',
      size: fontSize,
      color: clr,
      underline: true,
      z: 10
    )

    currentX += space
  end
end

def displayMessage(first,second,nodes,fontSize)
  content = "Edit distance of (#{first} -> #{second}) is #{getTotalDistance(nodes)}."

  Text.new(
    content,
    x: 100, y: 100,
    font: 'CamingoCode-Regular.ttf',
    size: fontSize,
    color: 'black',
    z: 10
  )
end

def main
  print "Enter string 1: "
  first = gets.chomp
  print "Enter string 2: "
  second = gets.chomp

  nodes = createNodes(first,second)
  setDistances(first,second,nodes)
  changes = getChanges(first,second,nodes)


  displayMessage(first,second,nodes,40)
  displayEdits(changes,80,50)

  show
end


# "assent" -> "descent"
# "precipitation" -> "participation"

# main
