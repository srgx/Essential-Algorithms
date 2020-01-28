class DoubleCell
  attr_accessor :value, :next, :previous
  def initialize(n) @value=n end
end

def insertCell(after_me,new_cell)
  new_cell.next=after_me.next # new_cell right link
  new_cell.previous=after_me # new_cell left link
  new_cell.next.previous=new_cell # right cell, left link
  new_cell.previous.next=new_cell # left cell, right link
end

def addAtBeginningDouble(top,new_cell)
  insertCell(top,new_cell)
end
