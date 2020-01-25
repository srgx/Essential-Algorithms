# Exercise 1
# Runtime is O(N^2)

def containsDuplicates(array)
  0.upto(array.size-1) do |i|
    0.upto(array.size-1) do |j|
      if(i!=j)
        if(array[i] == array[j]) then return true end
      end
    end
  end
  return false
end

def containsDuplicates2(array)
  0.upto(array.size-2) do |i|
    (i+1).upto(array.size-1) do |j|
      if(array[i] == array[j]) then return true end
    end
  end
  return false
end

err = "ERROR"

noDups = [12,33,4,7,99]
dups = [12,33,4,7,4,99]

if containsDuplicates(noDups) then raise err end
if !containsDuplicates(dups) then raise err end
if containsDuplicates2(noDups) then raise err end
if !containsDuplicates2(dups) then raise err end
