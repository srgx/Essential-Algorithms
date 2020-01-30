require_relative 'exercise4.rb'
# Exercise 11

def carpet(depth,side,position)
  if(depth.zero?)
    Square.new(
      x: position.x, y: position.y,
      size: side,
      color: 'blue',
      z: 10
    )
  else
    ns = side/3.0 # new side
    px,py = position.x, position.y
    nd = depth-1 # new depth

    carpet(nd,ns,Point.new(px,py))
    carpet(nd,ns,Point.new(px+ns,py))
    carpet(nd,ns,Point.new(px+2*ns,py))

    carpet(nd,ns,Point.new(px,py+ns))
    carpet(nd,ns,Point.new(px+2*ns,py+ns))

    carpet(nd,ns,Point.new(px,py+2*ns))
    carpet(nd,ns,Point.new(px+ns,py+2*ns))
    carpet(nd,ns,Point.new(px+2*ns,py+2*ns))
  end
end


 # carpet(4,600,Point.new(100,100))
 # show
