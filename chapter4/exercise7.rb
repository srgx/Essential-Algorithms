# Exercise 7

def showArray(arr)
  arr.each { |r| p r }
end

# main diagonal(on or below 1, above 0)
def fillArr(arr)
  0.upto(arr.size-1) do |i|
    0.upto(arr[0].size-1) do |j|
      arr[i][j] = (i>=j) ? 1 : 0
    end
  end
end


empty_arr=[]
6.times { empty_arr << Array.new(6) }

=begin
fillArr(empty_arr)
showArray(empty_arr)
=end
