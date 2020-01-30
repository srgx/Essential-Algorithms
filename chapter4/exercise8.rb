require_relative 'exercise7.rb'
# Exercise 8

# antidiagonal(on or above 1, below 0)
def fillArr2(arr)
  width=arr[0].size
  0.upto(arr.size-1) do |i|
    0.upto(arr[0].size-1) do |j|
      arr[i][j] = (j+i<width) ? 1 : 0
    end
  end
end

empty_arr=[]
6.times { empty_arr << Array.new(6) }


=begin
fillArr2(empty_arr)
showArray(empty_arr)
=end
