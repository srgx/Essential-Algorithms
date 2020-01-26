# Exercise 5
# Runtime is O(M)

def pick(arr,m)
  max_i = arr.size-1
  for i in 0..m-1
    j = rand(i..max_i)
    arr[i],arr[j] = arr[j],arr[i]
  end
  return arr[0..m-1]
end
