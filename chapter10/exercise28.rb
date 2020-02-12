# Exercise 28

LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

class TrieNode
  attr_accessor :key, :value, :children

  def initialize
    @key=""
  end

  def addValue(new_key,new_value)

    if(new_key!=""&&new_key==@key)
      @value = new_value
      return
    end

    if(new_key==""&&new_key==@key)
      @value = new_value
      return
    end

    if(new_key==""&&@key!="")
      self.createChildren
      indx = indexOf(@key[0])
      new_node = TrieNode.new
      new_node.key = @key[1..]
      new_node.value = @value
      @children[indx] = new_node
      @key = ""
      @value = new_value
      return
    end

    indx = indexOf(new_key[0])
    @children[indx].addValue(new_key[1..],new_value)
  end

  def findValue(target_key)
    if(target_key==@key) then return @value end
    if(@children==nil) then return nil end

    indx = indexOf(target_key[0])
    if(@children[indx]==nil) then return nil end
    return @children[indx].findValue(target_key[1..])
  end

  def createChildren
    @children = Array.new(26)
  end
end

def indexOf(l)
  l = l.upcase
  return LETTERS.index(l)
end

# sentinel = TrieNode.new

sentinel = TrieNode.new
sentinel.createChildren
w = TrieNode.new
w.createChildren
a = TrieNode.new
a.createChildren
n = TrieNode.new
n.createChildren
e = TrieNode.new
t = TrieNode.new
t.createChildren
d = TrieNode.new
d.key = "D"

sp = TrieNode.new
sp.key="SP"
sp.value = 72


sentinel.children[indexOf("W")] = w
w.children[indexOf("A")] = a
w.children[indexOf("I")] = sp
a.children[indexOf("N")] = n
n.children[indexOf("E")] = e
e.value = 29
n.children[indexOf("T")] = t
t.value = 36
t.children[indexOf("E")] = d

sentinel.addValue("WANTED",10)
sentinel.addValue("WAN",18)
sentinel.addValue("WI",66)
sentinel.addValue("WIS",0)
sentinel.addValue("WANER",99)

puts sentinel.findValue("WANTED")
puts sentinel.findValue("WAN")
puts sentinel.findValue("WI")
puts sentinel.findValue("WISP")
puts sentinel.findValue("WIS")
