require_relative 'exercise7.rb'
require_relative 'exercise8.rb'
# Exercise 9

def sierpinski(depth,dx,dy,cr)
  cr = sierpRight(depth,dx,dy,cr)
  cr = drawRelative(dx,dy,cr)
  cr = sierpDown(depth,dx,dy,cr)
  cr = drawRelative(-dx,dy,cr)
  cr = sierpLeft(depth,dx,dy,cr)
  cr = drawRelative(-dx,-dy,cr)
  cr = sierpUp(depth,dx,dy,cr)
  drawRelative(dx,-dy,cr)
end

# sierpinski(4,12,12,Point.new(100,100))
# show
