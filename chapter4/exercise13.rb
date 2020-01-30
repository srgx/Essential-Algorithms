require_relative 'exercise5.rb'
require_relative 'exercise12.rb'
# Exercise 13


def multiplyTriangular(a,b,s)
  new_arr = Array.new(a.size,0)
  0.upto(s-1) do |i|
    0.upto(s-1) do |j|
      0.upto(s-1) do |k|
        if(k<=i&&k>=j)
          new_arr[findIndex(i,j)]+=a[findIndex(i,k)]*b[findIndex(k,j)]
        end
      end
    end
  end
  return new_arr
end


raise ERR if(multiplyTriangular(TR1,TR2,3))!=[28,56,56,69,94,18]
