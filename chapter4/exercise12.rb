# Exercise 12

def showTriangular(a)
  c=row=1
  0.upto(a.size-1) do |i|
    print "[#{a[i]}]"
    c-=1
    if(c==0)
      row+=1
      c=row
      puts
    end
  end
end

def addTriangular(a,b)
  new_arr=Array.new(a.size,0)
  0.upto(a.size-1) do |i|
    new_arr[i]=a[i]+b[i]
  end
  return new_arr
end



TR1 = [4,
       2,7,
       3,5,9]

TR2 = [7,
       6,8,
       2,6,2]


raise ERR if(addTriangular(TR1,TR2))!=[11,8,15,5,11,11]
