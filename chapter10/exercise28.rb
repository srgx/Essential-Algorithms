# Exercise 28

LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

class TrieNode
  attr_accessor :key, :value, :children

  def initialize
    @key=""
  end

  def addValue(new_key,new_value)
    # if key matches current node(only for leaf nodes)
    if(new_key!=""&&new_key==@key)
      @value = new_value
      return
    end

    # if both keys are empty
    if(new_key==""&&new_key==@key)
      @value = new_value
      return
    end

    # if key is empty and leaf is not empty
    # make space for new node
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

    # create children and make space
    # for new node if key wasnt empty
    if(@children.nil?)
      self.createChildren
      if(@key!="")
        indx = indexOf(@key[0])
        new_node = TrieNode.new
        new_node.key = @key[1..]
        new_node.value = @value
        @children[indx] = new_node
        @key = ""
      end
    end

    # if node doesnt exist create it
    # with new value and rest of key
    indx = indexOf(new_key[0])
    if(@children[indx].nil?)
      @children[indx] = TrieNode.new
      @children[indx].key = new_key[1..]
      @children[indx].value = new_value
    end

    # continue if node exists
    @children[indx].addValue(new_key[1..],new_value)
  end

  def findValue(target_key)
    # value is found
    if(target_key==@key) then return @value end

    # end of path, return nil
    if(@children==nil) then return nil end

    # node doesnt exist, return nil
    indx = indexOf(target_key[0])
    if(@children[indx]==nil) then return nil end

    # keep searching
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


se = TrieNode.new

se.addValue("wane",18)
se.addValue("wanted",15)
se.addValue("want",33)

se.addValue("apple",10)
se.addValue("app",20)
se.addValue("bear",30)
se.addValue("ant",40)
se.addValue("bat",50)
se.addValue("ape",60)

raise "Error" if se.findValue("wane") != 18
raise "Error" if se.findValue("wanted") != 15
raise "Error" if se.findValue("want") != 33

raise "Error" if se.findValue("apple") != 10
raise "Error" if se.findValue("app") != 20
raise "Error" if se.findValue("bear") != 30
raise "Error" if se.findValue("ant") != 40
raise "Error" if se.findValue("bat") != 50
raise "Error" if se.findValue("ape") != 60
