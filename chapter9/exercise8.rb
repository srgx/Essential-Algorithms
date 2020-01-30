# Exercise 8

def sierpRight(depth,dx,dy,cr)
  if(depth>0)
    depth = depth - 1
    cr = sierpRight(depth,dx,dy,cr)
    cr = drawRelative(dx,dy,cr)
    cr = sierpDown(depth,dx,dy,cr)
    cr = drawRelative(2*dx,0,cr)
    cr = sierpUp(depth,dx,dy,cr)
    cr = drawRelative(dx,-dy,cr)
    cr = sierpRight(depth,dx,dy,cr)
  end
  return cr
end

def sierpDown(depth,dx,dy,cr)
  if(depth>0)
    depth = depth - 1
    cr = sierpDown(depth,dx,dy,cr)
    cr = drawRelative(-dx,dy,cr)
    cr = sierpLeft(depth,dx,dy,cr)
    cr = drawRelative(0,2*dy,cr)
    cr = sierpRight(depth,dx,dy,cr)
    cr = drawRelative(dx,dy,cr)
    cr = sierpDown(depth,dx,dy,cr)
  end
  return cr
end

def sierpLeft(depth,dx,dy,cr)
  if(depth>0)
    depth = depth - 1
    cr = sierpLeft(depth,dx,dy,cr)
    cr = drawRelative(-dx,-dy,cr)
    cr = sierpUp(depth,dx,dy,cr)
    cr = drawRelative(-2*dx,0,cr)
    cr = sierpDown(depth,dx,dy,cr)
    cr = drawRelative(-dx,dy,cr)
    cr = sierpLeft(depth,dx,dy,cr)
  end
  return cr
end

def sierpUp(depth,dx,dy,cr) #
  if(depth>0)
    depth = depth - 1
    cr = sierpUp(depth,dx,dy,cr)
    cr = drawRelative(dx,-dy,cr)
    cr = sierpRight(depth,dx,dy,cr)
    cr = drawRelative(0,-2*dy,cr)
    cr = sierpLeft(depth,dx,dy,cr)
    cr = drawRelative(-dx,-dy,cr)
    cr = sierpUp(depth,dx,dy,cr)
  end
  return cr
end
