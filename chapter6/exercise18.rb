require_relative 'exercise13.rb'
# Exercise 18

def bucketSort(array,max_value,number_of_buckets)

  size=array.size
  buckets=Array.new(number_of_buckets)
  0.upto(number_of_buckets-1) { |i| buckets[i]=Array.new }
  bucket_width=(max_value+1)/number_of_buckets.to_f

  0.upto(array.size-1) do |i|
    value=array[i]
    index=(value/bucket_width).to_i
    buckets[index] << value
  end

  index=0
  buckets.each do |bkt|
    quickSort3(bkt,0,bkt.size-1)
    0.upto(bkt.size-1) do |i|
      array[index] = bkt[i]
      index+=1
    end
  end

end


arr=[]
ARRAY_SIZE.times { arr << rand(RAND_RANGE) }
bucketSort(arr,RAND_RANGE,RAND_RANGE/10)
unless(isSortedAsc(arr)) then raise ERR end
