# Exercise 15
# Middle rectangle can reduce error for increasing and decreasing curves


poly = lambda{ |x| x**2 }
linear = lambda { |x| x*2 }
constant = lambda { |x| 10 }


# Left
def rectangleRule(func,xmin,xmax,intervals)
  dx=(xmax-xmin)/intervals
  total_area=0
  x=xmin
  intervals.times do
    total_area = total_area + dx*func.call(x)
    x+=dx
  end
  return total_area
end

# Middle
def rectangleRule2(func,xmin,xmax,intervals)
  dx=(xmax-xmin)/intervals
  total_area=0
  x=xmin+dx/2
  intervals.times do
    total_area = total_area + dx*func.call(x)
    x+=dx
  end
  return total_area
end


if(rectangleRule(poly,0,200,25)!=2508800) then raise "Error" end
if(rectangleRule2(poly,0,200,25)!=2665600) then raise "Error" end
