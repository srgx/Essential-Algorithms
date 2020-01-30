# Exercise 3

def findMedianSorted(arr)
  s=arr.size
  m=s/2
  if(s%2!=0)
    return arr[m]
  else
    return (arr[m]+arr[m-1])/2.0
  end
end

raise ERR if(findMedianSorted([1,2,3])!=2)
raise ERR if(findMedianSorted([1,8,12,45,69])!=12)
raise ERR if(findMedianSorted([1,2,3,4,9,12,15])!=4)
raise ERR if(findMedianSorted([12,33,98,131])!=65.5)
