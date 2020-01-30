require_relative 'exercise4.rb'
# Exercise 5

# angle is angle of whole curve, ang is angle of next depths
def drawKoch(depth,pt1,angle,length,color,ang=60)
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
    side=length/3.0 # triangle side
    s=Math.cos(ang*v)*side*2 # triangle bottom(space between 2 parts)
    part=(length-s)/2.0

    pt2=Point.new
    pt2.x=part*Math.cos(angle_radians)+pt1.x
    pt2.y=part*Math.sin(angle_radians)+pt1.y

    pt3=Point.new
    pt3.x=side*Math.cos((angle-ang)*v)+pt2.x
    pt3.y=side*Math.sin((angle-ang)*v)+pt2.y

    pt4=Point.new
    pt4.x=side*Math.cos((angle+ang)*v)+pt3.x
    pt4.y=side*Math.sin((angle+ang)*v)+pt3.y

    drawKoch(depth-1,pt1,angle,part,color,ang)
    drawKoch(depth-1,pt2,angle-ang,side,color,ang)
    drawKoch(depth-1,pt3,angle+ang,side,color,ang)
    drawKoch(depth-1,pt4,angle,part,color,ang)
  end
end
