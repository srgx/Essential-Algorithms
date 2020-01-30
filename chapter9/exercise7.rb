require_relative 'exercise4.rb'
# Exercise 7

def drawRelative(x,y,current)
  targetX = current.x + x
  targetY = current.y + y
  Line.new(
    x1: current.x, y1: current.y,
    x2: targetX, y2: targetY,
    width: 3,
    color: 'fuchsia',
    z: 20
  )

  return Point.new(targetX,targetY)
end


def hilbert(depth,dx,dy,current)
  if(depth>0)
    current = hilbert(depth-1,dy,dx,current)
  end
  current = drawRelative(dx,dy,current)
  if(depth>0)
    current = hilbert(depth-1,dx,dy,current)
  end
  current = drawRelative(dy,dx,current)
  if(depth>0)
    current = hilbert(depth-1,dx,dy,current)
  end
  current = drawRelative(-dx,-dy,current)
  if(depth>0)
    current = hilbert(depth-1,-dy,-dx,current)
  end
  return current
end

# hilbert(4,20,0,Point.new(20,20))
# show
