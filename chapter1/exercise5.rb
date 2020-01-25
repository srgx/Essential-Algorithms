# Exercise 5
# Runtime is O(N^2)

LETTERS = ["A","B","C","D"]

def pairs(le)
  res = []
  0.upto(le.size-1) do |i|
    (i+1).upto(le.size-1) do |j|
      res << [le[i],le[j]]
    end
  end
  return res
end

LETTER_PAIRS = [["A", "B"], ["A", "C"],
                ["A", "D"], ["B", "C"],
                ["B", "D"], ["C", "D"]]

if pairs(LETTERS)!=LETTER_PAIRS then raise err end
