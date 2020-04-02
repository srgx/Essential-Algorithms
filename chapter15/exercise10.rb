# Exercise 10

class Transition
  attr_reader :through, :to
  def initialize(through,to)
    @through, @to = through, to
  end
end

class Node
  attr_reader :id, :accepting
  def initialize(id)
    @id, @transitions, @accepting = id, [], false
  end

  def addTransition(tr)
    @transitions << tr
  end

  def nextFor(symbol)
    transition = @transitions.find { |tr| tr.through == symbol}
    return transition&.to
  end

  def accept
    @accepting = true
  end
end

def getNode(nodes,id)
  node = nodes.find { |nd| nd.id == id }
  if(node.nil?)
    node = Node.new(id)
    nodes << node
  end
  return node
end

def checkString(nodes,string)

  # find start node
  currentNode = nodes.find { |nd| nd.id.zero? }

  # check if path to accepting state exists
  string.each_char do |ch|
    currentNode = currentNode.nextFor(ch)
    break if currentNode.nil?
    return true if currentNode.accepting
  end

  # no accepting state found
  return false
end


def createNodes(transitions)
  nodes = []
  transitions.each do |tr|

    # read transition from string
    arr = tr.split
    fromId, toId, through, acc = arr[0].to_i, arr[2].to_i, arr[1], arr[3]

    # get or create nodes if necessary
    fromNode = getNode(nodes,fromId)
    toNode = getNode(nodes,toId)

    # if transition was marked with Y, target node is in accepting state
    toNode.accept if(acc=='Y')

    # add transition
    fromNode.addTransition(Transition.new(through,toNode))
  end

  return nodes
end


def main

  # get transitions from user
  puts "Enter state transitions"
  transitions = []
  input = gets.chomp
  while(input!="")
    transitions << input
    input = gets.chomp
  end

  # create nodes from input strings
  nodes = createNodes(transitions)

  # get test string
  puts "Enter string"
  str = gets.chomp

  # test input string and print answer
  answer = checkString(nodes,str) ? "valid" : "invalid"
  puts "String \"#{str}\" is #{answer}"

end


# main

# -------------------------------------------------------------
# TESTS
# -------------------------------------------------------------
ER = "Error"
transitions = ["0 A 1 N","1 B 1 N", "1 A 2 Y"]
nodes = createNodes(transitions)
raise ER if checkString(nodes,"ABBBB")
raise ER if checkString(nodes,"BABBBB")
raise ER unless checkString(nodes,"ABBBBA")
raise ER unless checkString(nodes,"ABBBBAAAA")
# -------------------------------------------------------------
