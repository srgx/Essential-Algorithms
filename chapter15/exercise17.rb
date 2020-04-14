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
  attr_reader :fromNode, :fromDirection, :distance, :diag
  def initialize
    @diag = false
  end

  def setDistance(dist)
    @distance = dist
  end

  def setFrom(node,from)
    @fromNode = node
    @fromDirection = from
  end

  def setDiag
    @diag = true
  end
end


# first = "assent"
# second = "descent"
# first = "precipitation"
# second = "participation"

print "Enter string 1: "
first = gets.chomp
print "Enter string 2: "
second = gets.chomp


nodes = []

height = second.size + 1
width = first.size + 1

# create nodes, set initial distances, add diagonal links
for i in 0...height
  row = []
  for j in 0...width
    row << Node.new

    # set source nodes and distances for top row and left column
    if(i.zero?)
      row[j].setDistance(j) # top row

      # set left node
      if(j>0)
        row[j].setFrom(row[j-1],:left)
      end

    elsif(j.zero?)
      row[j].setDistance(i) # left column

      # set top node
      row[j].setFrom(nodes.dig(i-1,j),:top)

    end

    # add diagonal links
    if(second[i]==first[j]&&i<height-1&&j<width-1)
      row[j].setDiag
    end

  end
  nodes << row
end


# set all remaining distances
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
      currentNode.setFrom(leftNode,:left)
    elsif(best==fromTop)
      currentNode.setFrom(topNode,:top)
    else
      currentNode.setFrom(diagNode,:diag)
    end

  end
end


def getDistance(nodes)
  return nodes.last.last.distance
end


def getChanges(nodes,first,second)

  current, changes = nodes.last.last, []
  wordPosition = [second.size-1,first.size-1]

  # read changes from end to start
  while(!current.fromNode.nil?)
    case current.fromDirection
    when :top
      changes << Change.new(second[wordPosition[0]],:add)
      wordPosition[0] -= 1
    when :left
      changes << Change.new(first[wordPosition[1]],:remove)
      wordPosition[1] -= 1
    when :diag
      changes << Change.new(second[wordPosition[0]],:nochange)
      wordPosition[0] -= 1
      wordPosition[1] -= 1
    end

    current = current.fromNode
  end

  return changes.reverse
end


# get list of changes
changes = getChanges(nodes,first,second)

content = "Edit distance of (#{first} -> #{second}) is #{getDistance(nodes)}."

Text.new(
  content,
  x: 100, y: 100,
  font: 'CamingoCode-Regular.ttf',
  size: 40,
  color: 'black',
  z: 10
)


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
    size: 80,
    color: clr,
    underline: true,
    z: 10
  )

  currentX += 50
end



show
