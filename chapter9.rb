# Exercises 1, 2

def factorial(n)
  return n.zero? ? 1 : n * factorial(n-1)
end

def fibonacci(n)
  return n<=1 ? n : fibonacci(n-1) + fibonacci(n-2)
end

ERR="Error"


# Exercise 5

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class Point
  attr_accessor :x, :y
  def initialize(x=0,y=0)
    @x=x
    @y=y
  end
end

def drawKoch(depth,pt1,angle,length,color)
  v=0.0174532925
  angle_radians=angle*v
  if(depth==0)
    xx=length*Math.cos(angle_radians)+pt1.x
    yy=length*Math.sin(angle_radians)+pt1.y
    Line.new(
      x1: pt1.x, y1: pt1.y,
      x2: xx, y2: yy,
      width: 2,
      color: color,
      z: 20
    )
  else
    pt2=Point.new
    pt2.x=(length/3.0)*Math.cos(angle_radians)+pt1.x
    pt2.y=(length/3.0)*Math.sin(angle_radians)+pt1.y

    pt3=Point.new
    pt3.x=(length/3.0)*Math.cos((angle-60)*v)+pt2.x
    pt3.y=(length/3.0)*Math.sin((angle-60)*v)+pt2.y

    pt4=Point.new
    pt4.x=(length/3.0)*2*Math.cos(angle_radians)+pt1.x
    pt4.y=(length/3.0)*2*Math.sin(angle_radians)+pt1.y

    drawKoch(depth-1,pt1,angle,length/3.0,color)
    drawKoch(depth-1,pt2,angle-60,length/3.0,color)
    drawKoch(depth-1,pt3,angle+60,length/3.0,color)
    drawKoch(depth-1,pt4,angle,length/3.0,color)
  end
end

# 4 Koch curves
snowFlake = lambda { |x,y,size,color|
  depth = 2
  drawKoch(depth,Point.new(x,y),0,size,color)
  drawKoch(depth,Point.new(x+size,y),90,size,color)
  drawKoch(depth,Point.new(x+size,y+size),180,size,color)
  drawKoch(depth,Point.new(x,y+size),270,size,color)
  }

# Koch snowflake(3 Koch curves)
realSnowFlake = lambda { |x,y,size,color|
  depth = 2
  pt3=Point.new(size/2+x,y+(size*Math.sqrt(3))/2.0)
  drawKoch(depth,Point.new(x,y),0,size,color)
  drawKoch(depth,Point.new(x+size,y),120,size,color)
  drawKoch(depth,pt3,240,size,color)
  }

COLORS=['blue','red','orange','green','lime','fuchsia','aqua','purple']

def star(startX,startY,startS,fun,dv)
  step=5
  55.times do
    fun.call(startX,startY,startS,COLORS[rand(COLORS.size)])
    startX+=step
    startY+=step/dv.to_f # dv=1 for snowFlake, dv=2 for realSnowFlake
    startS-=step*2
  end
end

#star(180,200,600,snowFlake,1)
#star(1140,200,600,realSnowFlake,2)
#show


# ----------------------------------------------------------------
# TESTS
# ----------------------------------------------------------------
raise ERR if(factorial(3)!=6)
raise ERR if(factorial(4)!=24)
raise ERR if(factorial(5)!=120)
raise ERR if(factorial(6)!=720)
# ----------------------------------------------------------------
raise ERR if(fibonacci(6)!=8)
raise ERR if(fibonacci(7)!=13)
raise ERR if(fibonacci(8)!=21)
raise ERR if(fibonacci(9)!=34)
# ----------------------------------------------------------------
