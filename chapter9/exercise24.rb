require_relative 'exercise4.rb'
# Exercise 24

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
  sections = []
  depths = []
  dxs = []
  dys = []

  section = 1

  while(section>0)
    if(section==1)
      section+=1
      if(depth>0)
        sections.push(section)
        depths.push(depth)
        dxs.push(dx)
        dys.push(dy)
        depth-=1
        dx, dy = dy, dx
        section = 1
      end
    elsif(section==2)
      current = drawRelative(dx,dy,current)
      section+=1
      if(depth>0)
        sections.push(section)
        depths.push(depth)
        dxs.push(dx)
        dys.push(dy)
        depth-=1
        section = 1
      end
    elsif(section==3)
      current = drawRelative(dy,dx,current)
      section+=1
      if(depth>0)
        sections.push(section)
        depths.push(depth)
        dxs.push(dx)
        dys.push(dy)
        depth-=1
        section = 1
      end
    elsif(section==4)
      current = drawRelative(-dx,-dy,current)
      section+=1
      if(depth>0)
        sections.push(section)
        depths.push(depth)
        dxs.push(dx)
        dys.push(dy)
        depth-=1
        dx, dy = -dy, -dx
        section = 1
      end
    elsif(section==5)
      if(sections.empty?)
        section = -1
      else
        section = sections.pop
        depth = depths.pop
        dx = dxs.pop
        dy = dys.pop
      end
    end
  end
end

# hilbert(4,20,0,Point.new(20,20))
# show
