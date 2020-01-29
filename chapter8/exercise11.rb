require_relative 'exercise2.rb'
require_relative 'exercise4.rb'
require_relative 'exercise5.rb'
require_relative 'exercise6.rb'
require_relative 'exercise7.rb'
require_relative 'exercise9.rb'
require_relative 'exercise10.rb'
# Exercise 11

HASH_TYPES=
{ sorted: HashTableSorted,
  unsorted: HashTable,
  linear: LinearHash,
  quadratic: QuadraticHash,
  pseudorandom: PseudorandomHash,
  double: DoubleHash,
  ordered_quadratic: OrderedQuadratic,
  ordered_double: OrderedDouble }


# return probe sequence lenghts ([12,33,44,55,66])
def measureSteps(type)
  s,num_values=101,90
  fail=true
  while(fail==true) # make sure num_values elements are successfully added
    h=HASH_TYPES[type].new(s)
    sequences=[]
    fail=false
    num_values.times do |i|
      if(h.addValue(rand(1..10**7),"")==nil)
        fail=true
        break
      end
      itindx=i+1
      if(itindx==50||itindx==60||itindx==70||itindx==80||itindx==90)
        sequences << h.getValue(rand(1..10**7),true)
      end
    end
  end
  return sequences
end

def averageSteps(type)
  averages=Array.new(5,0)
  tests=1000
  tests.times do
    sequences=measureSteps(type)
    0.upto(sequences.size-1) do |i|
      averages[i]+=sequences[i]
    end
  end
  0.upto(averages.size-1) do |i|
    averages[i]/=tests.to_f
  end
  return averages
end


def graphOpenAddressing
  puts "Probe lengths for hash table with open addressing."
  puts "50, 60, 70, 80, 90 items, table size - 101"
  print "Linear "
  p averageSteps(:linear)
  print "Quadratic "
  p averageSteps(:quadratic)
  print "Pseudorandom "
  p averageSteps(:pseudorandom)
  print "Double "
  p averageSteps(:double)
  print "Ordered Quadratic "
  p averageSteps(:ordered_quadratic)
  print "Ordered Double "
  p averageSteps(:ordered_double)
end

ERR="Error"
def hashTest(type)
  s=10

  h=HASH_TYPES[type].new(s)

  # ADD VALUES
  raise ERR if(h.addValue(95,"A")!="A")
  raise ERR if(h.addValue(65,"B")!="B")
  raise ERR if(h.addValue(65,"Duplicate")!=nil)
  raise ERR if(h.addValue(25,"C")!="C")
  raise ERR if(h.addValue(121,"D")!="D")
  raise ERR if(h.addValue(83,"E")!="E")
  raise ERR if(h.addValue(22,"F")!="F")

  # GET VALUES
  raise ERR if(h.getValue(95)!="A")
  raise ERR if(h.getValue(65)!="B")
  raise ERR if(h.getValue(25)!="C")
  raise ERR if(h.getValue(121)!="D")
  raise ERR if(h.getValue(83)!="E")
  raise ERR if(h.getValue(22)!="F")

  # ABSENCE
  0.upto(21) { |i| raise ERR if(h.getValue(i)!=nil) }

  # DELETE VALUES
  raise ERR if(h.deleteValue(95)!="A")
  raise ERR if(h.deleteValue(65)!="B")
  raise ERR if(h.deleteValue(121)!="D")
  raise ERR if(h.deleteValue(35)!=nil)
  raise ERR if(h.deleteValue(65)!=nil)

  # GET VALUES
  raise ERR if(h.getValue(25)!="C")
  raise ERR if(h.getValue(83)!="E")
  raise ERR if(h.getValue(22)!="F")
  raise ERR if(h.getValue(95)!=nil)
  raise ERR if(h.getValue(65)!=nil)
  raise ERR if(h.getValue(121)!=nil)

  # DELETE VALUES
  raise ERR if(h.deleteValue(22)!="F")
  raise ERR if(h.deleteValue(25)!="C")
  raise ERR if(h.deleteValue(83)!="E")

end


hashTest(:unsorted)
hashTest(:sorted)
hashTest(:linear)
hashTest(:quadratic)
hashTest(:pseudorandom)
hashTest(:double)
hashTest(:ordered_quadratic)
hashTest(:ordered_double)
