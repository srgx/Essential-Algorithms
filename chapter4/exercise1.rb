# Exercise 1

def average(arr)
  sum=0
  arr.each { |i| sum+=i }
  return sum/arr.size.to_f
end

def sampleVariance(arr)
  avr=average(arr)
  s=0
  0.upto(arr.size-1) { |x| s+=(arr[x]-avr)**2 }
  return s/(arr.size-1)
end


ERR="Error"
SAMPLE1=[3,5,9,12]
SAMPLE2=[17,15,23,7,9,13]

raise ERR if(sampleVariance(SAMPLE1)!=16.25)
raise ERR if(sampleVariance(SAMPLE2)!=33.2)
