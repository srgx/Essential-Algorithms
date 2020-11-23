require_relative 'exercise6.rb'
# Exercise 9
# After finding index move left until different value is found
# Worst case run time is O(N)

# Return first occurence of target item
def interpolationFirst(array,value)
  index=interpolationSearch(array,value)
  loop do
    index-=1
    break if array[index]!=value
  end
  return index+1
end

arr = [4,5,5,5,5,5,5];

raise ERR if(interpolationSearch(arr,5)!=3)
raise ERR if(interpolationFirst(arr,5)!=1)
