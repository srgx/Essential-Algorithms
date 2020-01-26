# Exercise 1

def linearSearch(array,value)
  for i in 0..array.size-1
    if(array[i]==value) then return i end
    if(array[i]>value) then return -1 end
  end
  return -1
end

ERR="Error"
NUMBERS=[12,33,43,56,99]

raise ERR unless(linearSearch(NUMBERS,2)==-1)
raise ERR unless(linearSearch(NUMBERS,100)==-1)
raise ERR unless(linearSearch(NUMBERS,43)==2)
raise ERR unless(linearSearch(NUMBERS,12)==0)
raise ERR unless(linearSearch(NUMBERS,99)==4)
