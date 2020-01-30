# Exercise 5

def sum_to(x)
  (x**2+x)/2
end

# lower left triangular array
def findIndex(r,c) # row, column
  cells_from_rows=sum_to(r)
  return cells_from_rows+c
end

# upper right triangular array (map rows in order)
def findIndex2(r,c,s) # row, column, size
  cells_from_rows=sum_to(s)-sum_to(s-r)
  return cells_from_rows+(c-r)
end

# upper right triangular array with different mapping (columns from findIndex are rows)
def findIndex3(r,c)
  return findIndex(c,r)
end


raise ERR if(findIndex(3,2)!=8)
raise ERR if(findIndex(4,3)!=13)
raise ERR if(findIndex2(0,2,5)!=2)
raise ERR if(findIndex2(1,2,5)!=6)
raise ERR if(findIndex2(2,3,5)!=10)
raise ERR if(findIndex2(3,3,5)!=12)
raise ERR if(findIndex2(4,4,5)!=14)
raise ERR if(findIndex3(0,2)!=3)
raise ERR if(findIndex3(1,3)!=7)
