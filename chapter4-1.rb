# Exercises 1,2
def sampleVariance(arr)
  avr=average(arr)
  s=0
  0.upto(arr.size-1) { |x| s+=(arr[x]-avr)**2 }
  return s/(arr.size-1)
end

def sampleStandardDeviation(arr)
  return Math.sqrt(sampleVariance(arr))
end

def average(arr)
  sum=0
  arr.each { |i| sum+=i }
  return sum/arr.size.to_f
end

ERR="Error"
SAMPLE1=[3,5,9,12]
SAMPLE2=[17,15,23,7,9,13]

if(sampleVariance(SAMPLE1)!=16.25) then raise ERR end
if(sampleVariance(SAMPLE2)!=33.2) then raise ERR end


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

if(findMedianSorted([1,2,3])!=2) then raise ERR end
if(findMedianSorted([1,8,12,45,69])!=12) then raise ERR end
if(findMedianSorted([1,2,3,4,9,12,15])!=4) then raise ERR end
if(findMedianSorted([12,33,98,131])!=65.5) then raise ERR end

# Exercise 4
exampleArray=[7,8,9,10]

def removeItem(arr,index)
  index.upto(arr.size-2) { | i | arr[i]=arr[i+1] }
  arr.pop # resize array
end


removeItem(exampleArray,1)
if(exampleArray!=[7,9,10]) then raise ERR end

# Exercises 5, 6

def sum_to(x)
  (x**2+x)/2
end

# lower left triangular array
def findIndex(r,c) # row, column
  cells_from_rows=sum_to(r)
  return cells_from_rows+c
end

# upper right triangular array (map rows in order)
def findIndex2(r,c,s) # row, column, size
  cells_from_rows=sum_to(s)-sum_to(s-r)
  return cells_from_rows+(c-r)
end

# upper right triangular array with different mapping (columns from findIndex are rows)
def findIndex3(r,c)
  return findIndex(c,r)
end

# upper left triangular array (rows from findIndex in reverse order)
# (r+c)<s
def findIndex4(r,c,s)
  findIndex(s-(r+1),c)
end


if(findIndex(3,2)!=8) then raise ERR end
if(findIndex(4,3)!=13) then raise ERR end
if(findIndex2(0,2,5)!=2) then raise ERR end
if(findIndex2(1,2,5)!=6) then raise ERR end
if(findIndex2(2,3,5)!=10) then raise ERR end
if(findIndex2(3,3,5)!=12) then raise ERR end
if(findIndex2(4,4,5)!=14) then raise ERR end
if(findIndex3(0,2)!=3) then raise ERR end
if(findIndex3(1,3)!=7) then raise ERR end
if(findIndex4(0,2,5)!=12) then raise ERR end
if(findIndex4(2,1,5)!=4) then raise ERR end
if(findIndex4(3,1,5)!=2) then raise ERR end
if(findIndex4(4,0,5)!=0) then raise ERR end


# Exercises 7, 8
def showArray(arr)
  arr.each { |r| p r }
end

EMPTY_ARR=[]
8.times { EMPTY_ARR << Array.new(6) }

# main diagonal(on or below 1, above 0)
def fillArr(arr)
  0.upto(arr.size-1) do |i|
    0.upto(arr[0].size-1) do |j|
      arr[i][j] = (i>=j) ? 1 : 0
    end
  end
end

# antidiagonal(on or below 0, above 1)
def fillArr2(arr)
  width=arr[0].size
  0.upto(arr.size-1) do |i|
    0.upto(arr[0].size-1) do |j|
      arr[i][j] = (j+i<width) ? 1 : 0
    end
  end
end

=begin
fillArr(EMPTY_ARR)
showArray(EMPTY_ARR)
puts "-------------------"
fillArr2(EMPTY_ARR)
showArray(EMPTY_ARR)
=end

# Exercise 9
rectangularArray=[]
8.times { rectangularArray << Array.new(8) }

def findMin(arr)
  min=arr[0]
  1.upto(arr.size-1) do |i|
    if(arr[i]<min) then min=arr[i] end
  end
  return min
end

# Distance to the nearest edge
def distances(arr)
  h,w=arr.size,arr[0].size
  0.upto(arr.size-1) do |i| # rows
    0.upto(arr[i].size-1) do |j| # cols
      arr[i][j]=findMin([i,j,h-(i+1),w-(j+1)]) # from top, left, bottom, right
    end
  end
end

# Exercise 10
# j<=i, k<=j

# 0 0 0 - 0
# 1 0 0 - 1
# 1 1 0 - 2
# 1 1 1 - 3
# 2 0 0 - 4
# 2 1 0 - 5
# 2 1 1 - 6
# 2 2 0 - 7
# 2 2 1 - 8
# 2 2 2 - 9

def tetrahedral(rows)
  return (rows**3+3*(rows**2)+2*rows)/6
end


def findIndexT(x,y,z)
  return tetrahedral(x)+sum_to(y)+z
end

indexT=0
0.upto(3) do |i|
  0.upto(i) do |j|
    0.upto(j) do |k|
      if(findIndexT(i,j,k)!=indexT) then raise ERR end
      indexT+=1
    end
  end
end

# Exercise 11
# Check if col<=row

# Exercises 12, 13

class Matrix
  attr_accessor :arr
  def initialize(arr)
    @arr = arr
  end

  def *(other)
    result = Matrix.new([[0,0,0],[0,0,0],[0,0,0]])
    0.upto(@arr.size-1) do |i|
      0.upto(@arr[0].size-1) do |j|
        result.arr[i][j]=0
        0.upto(@arr[0].size-1) do |k|
          result.arr[i][j]+=(@arr[i][k]*other.arr[k][j])
        end
      end
    end
    return result
  end
end

matrix1 = Matrix.new([[1,2,3],
                      [4,5,6],
                      [8,2,55]])

matrix2 = Matrix.new([[7,8,9],
                      [12,1,33],
                      [5,6,2]])

res = matrix1 * matrix2

if(res.arr!=[[46, 28, 81],
             [118, 73, 213],
             [355, 396, 248]]) then raise ERR end


class Triangular
  attr_accessor :arr
  def initialize(arr,size)
    @arr = arr
    @size = size # triangle side
  end

  def show
    c=row=1
    0.upto(@arr.size-1) do |i|
      print "[#{@arr[i]}]"
      c-=1
      if(c==0)
        row+=1
        c=row
        puts
      end
    end
  end

  def *(other)
    new_arr=Triangular.new(Array.new(@arr.size,0),@size)
    0.upto(@size-1) do |i|
      0.upto(@size-1) do |j|
        0.upto(@size-1) do |k|
          if(k<=i&&k>=j)
            new_arr.arr[findIndex(i,j)]+=@arr[findIndex(i,k)]*other.arr[findIndex(k,j)]
          end
        end
      end
    end
    return new_arr
  end

  def +(other)
    new_arr=Triangular.new(Array.new(@arr.size,0),@size)
    0.upto(@arr.size-1) do |i|
      new_arr.arr[i]=@arr[i]+other.arr[i]
    end
    return new_arr
  end
end


tr1 = Triangular.new([4,
                      2,7,
                      3,5,9],3)

tr2 = Triangular.new([7,
                      6,8,
                      2,6,2],3)


raise ERR if((tr1*tr2).arr!=[28,56,56,69,94,18])
raise ERR if((tr1+tr2).arr!=[11,8,15,5,11,11])
