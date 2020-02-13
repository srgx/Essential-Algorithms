# Exercise 26

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class Rectangle
  def left
    return @x
  end

  def right
    return @x + @width
  end

  def top
    return @y
  end

  def bot
    return @y+@height
  end
end


class QuadtreeNode
  attr_accessor :items, :area, :xMid, :yMid
  attr_accessor :NWchild, :NEchild, :SEchild, :SWchild

  @@maxItems = 100

  def initialize(area)
    @area = area # rectangle
    @xMid = (@area.left + @area.right) / 2.0
    @yMid = (@area.top + @area.bot) / 2.0
    @items = []
  end

  def addItem(new_item)
    if((!@items.nil?)&&(@items.size+1>@@maxItems))
      wid = (@area.right - @area.left) / 2.0
      hgt = (@area.bot - @area.top) / 2.0
      @NWchild = QuadtreeNode.new(createRectangle(@area.left, @area.top, wid, hgt))
      @NEchild = QuadtreeNode.new(createRectangle(@area.left + wid,@area.top, wid, hgt))
      @SEchild = QuadtreeNode.new(createRectangle(@area.left + wid,@area.top + hgt, wid, hgt))
      @SWchild = QuadtreeNode.new(createRectangle(@area.left,@area.top + hgt, wid,hgt))

      @items.each do |itm|
        if(itm.y<@yMid)
          if(itm.x < @xMid)
            @NWchild.addItem(itm)
          else
            @NEchild.addItem(itm)
          end
        else
          if(itm.x<@xMid)
            @SWchild.addItem(itm)
          else
            @SEchild.addItem(itm)
          end
        end
      end
      @items = nil
    end
    if(!@items.nil?)
      @items << new_item
    elsif(new_item.y < @yMid)
      if(new_item.x<@xMid)
        @NWchild.addItem(new_item)
      else
        @NEchild.addItem(new_item)
      end
    else
      if(new_item.x<@xMid)
        @SWchild.addItem(new_item)
      else
        @SEchild.addItem(new_item)
      end
    end
  end
end

def createLine(x1,y1,x2,y2)
  Line.new(
    x1: x1, y1: y1,
    x2: x2, y2: y2,
    width: 10,
    color: 'black',
    z: 20
  )
end

def createRectangle(x,y,width,height)
  rec = Rectangle.new(
    x: x, y: y,
    width: width, height: height,
    color: 'yellow',
    z: 10
  )

  createLine(x,y,x+width,y) # top line
  createLine(x,y,x,y+height) # left line
  createLine(x,y+height,x+width,y+height) # bottom line
  createLine(x+width,y,x+width,y+height) # right line

  return rec
end


rec = createRectangle(0,0,1920,1080)

quad = QuadtreeNode.new(rec)


500.times do
  x = rand 1920
  y = rand 1080
  circ = Circle.new(
    x: x, y: y,
    radius: 10,
    sectors: 32,
    color: 'fuchsia',
    z: 20
  )
  quad.addItem(circ)
end

# show
