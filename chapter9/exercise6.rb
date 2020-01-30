require_relative 'exercise5.rb'
# Exercise 6

# 4 Koch curves
snowFlake = lambda { |point,size,color,angle=60,depth=3|
  x,y=point.x,point.y
  drawKoch(depth,Point.new(x,y),0,size,color,angle)
  drawKoch(depth,Point.new(x+size,y),90,size,color,angle)
  drawKoch(depth,Point.new(x+size,y+size),180,size,color,angle)
  drawKoch(depth,Point.new(x,y+size),270,size,color,angle)
  }

# Koch snowflake(3 Koch curves)
realSnowFlake = lambda { |point,size,color,angle=60,depth=3|
  x,y=point.x,point.y
  pt3=Point.new(size/2+x,y+(size*Math.sqrt(3))/2.0)
  drawKoch(depth,Point.new(x,y),0,size,color,angle)
  drawKoch(depth,Point.new(x+size,y),120,size,color,angle)
  drawKoch(depth,pt3,240,size,color,angle)
  }


COLORS=['blue','red','orange','green','lime','fuchsia','aqua','purple']

def star(point,startS,fun,dv)
  startX,startY=point.x,point.y
  step=100
  5.times do
    fun.call(Point.new(startX,startY),startS,COLORS[rand(COLORS.size)])
    startX+=step
    startY+=step/dv.to_f # dv=1 for snowFlake, dv=2 for realSnowFlake
    startS-=step*2
  end
end


# snowFlake.call(Point.new(400,300),500,'red',85,5)
# realSnowFlake.call(Point.new(400,300),500,'red',60,5)
# star(Point.new(180,200),600,snowFlake,1)
# star(Point.new(1140,200),600,realSnowFlake,2)
# show
