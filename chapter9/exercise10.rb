require_relative 'exercise4.rb'
# Exercise 10

def gasket(depth,side,position)
  half_side=side/2.0
  height = Math::sqrt(side**2 - half_side**2)

  if(depth.zero?)
    Triangle.new(
      x1: position.x,  y1: position.y, # top
      x2: position.x+half_side, y2: position.y+height, # right
      x3: position.x-half_side, y3: position.y+height, # left
      color: 'red',
      z: 100
    )
  else
    new_half = (half_side/2.0)
    new_height = Math::sqrt(half_side**2 - new_half**2)
    left_top = Point.new(position.x - new_half,position.y+new_height)
    right_top = Point.new(position.x + new_half,position.y+new_height)

    gasket(depth-1,half_side,position) # top
    gasket(depth-1,half_side,left_top) # left
    gasket(depth-1,half_side,right_top) # right
  end
end

 # gasket(6,1000,Point.new(800,100))
 # show
