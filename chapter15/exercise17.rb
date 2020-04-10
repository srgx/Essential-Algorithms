# Exercise 17

class Node
  attr_reader :links, :distance, :diag
  def initialize
    @diag = false
  end

  def setDistance(dist)
    @distance = dist
  end

  def setDiag
    @diag = true
  end
end


first = "assent"
second = "descent"

# first = "precipitation"
# second = "participation"

nodes = []

height = second.size + 1
width = first.size + 1

# create nodes, set initial distances, add diagonal links
for i in 0...height
  row = []
  for j in 0...width
    row << Node.new

    # set distances for top row and left column
    if(i.zero?)
      row[j].setDistance(j) # top row
    elsif(j.zero?)
      row[j].setDistance(i) # left column
    end

    # add diagonal links
    if(second[i]==first[j]&&i<height-1&&j<width-1)
      # puts "Setting diag from #{i}-#{j}"
      row[j].setDiag
    end

  end
  nodes << row
end

# set all remaining distances
for i in 1..second.size
  for j in 1..first.size

    nd = nodes[i-1][j-1]

    # set best distance(left, top, diagonal)
    nodes[i][j].setDistance([nodes[i][j-1].distance + 1,
                             nodes[i-1][j].distance + 1,
                             nd.diag ? nd.distance : Float::INFINITY]
                             .min)

  end
end


# edit distance is in bottom right node
puts "Edit distance is #{nodes[height-1][width-1].distance}"
