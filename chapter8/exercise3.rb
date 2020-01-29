# Exercise 3
# Sorted hash tables with chaining have shorter average probe length
# Both hash tables have similar growth rate but algorithm with sorting
# gives shorter probe sequences

def measureSortedUnsorted(items,type)
  num_items = items
  limit = 10000
  tests = 100
  hsh = (type==:sorted) ? HashTableSorted.new(10) : HashTable.new(10)
  num_items.times do
    v = rand(limit)
    hsh.addValue(v,"")
  end

  sum = 0

  tests.times { sum += hsh.getValue(rand(limit),true) }

  return sum / tests.to_f
end


def graphChaining
  unsrtd = []
  srtd = []
  i = 50
  5.times do
    unsrtd << measureSortedUnsorted(i,:unsorted)
    srtd << measureSortedUnsorted(i,:sorted)
    i += 50
  end

  puts "Probe lengths for hash table with chaining."
  puts "50, 100, 150, 200, 250 items, 10 buckets"
  puts "Unsorted"
  p unsrtd
  puts "Sorted"
  p srtd
end
