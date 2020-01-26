require_relative 'exercise1'
# Exercise 2

def linearSearchR(array,value,index)
  if(index>=array.size||array[index]>value)
    return -1
  elsif(array[index]==value)
    return index
  else
    return linearSearchR(array,value,index+1)
  end
end

raise ERR unless(linearSearchR(NUMBERS,2,0)==-1)
raise ERR unless(linearSearchR(NUMBERS,100,0)==-1)
raise ERR unless(linearSearchR(NUMBERS,43,0)==2)
raise ERR unless(linearSearchR(NUMBERS,12,0)==0)
raise ERR unless(linearSearchR(NUMBERS,99,0)==4)
