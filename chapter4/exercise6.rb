require_relative 'exercise5.rb'
# Exercise 6

# upper left triangular array (rows from findIndex in reverse order)
# (r+c)<s
def findIndex4(r,c,s)
  findIndex(s-(r+1),c)
end


raise ERR if(findIndex4(0,2,5)!=12)
raise ERR if(findIndex4(2,1,5)!=4)
raise ERR if(findIndex4(3,1,5)!=2)
raise ERR if(findIndex4(4,0,5)!=0)
