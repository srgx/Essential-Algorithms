# Exercises 1, 2, 3
# Sorted hash tables with chaining have shorter average probe lengths

class Cell
  attr_accessor :id, :value, :next

  def addAfterMe(id,value)
    new_cell=Cell.new
    new_cell.id=id
    new_cell.value=value
    new_cell.next=self.next
    self.next=new_cell
  end
end

class AbstractHash
  def initialize(size)
    @size=size
    @array=Array.new(@size)
    0.upto(@array.size-1) do |i|
      @array[i]=Cell.new
    end
  end

  def showBucket(id)
    i=id%@size
    sentinel=@array[i]
    while(sentinel.next!=nil)
      puts sentinel.next.id
      sentinel=sentinel.next
    end
  end
end


class HashTable < AbstractHash
  def addValue(id,value)
    res,v=self.getValue(id),nil
    unless(res!=nil)
      i=id%@size
      @array[i].addAfterMe(id,value)
      v=value
    end

    return v
  end

  def getValue(id,sequence=nil)
    i=id%@size
    bucket=@array[i]
    s=0
    while((r=bucket.next)!=nil&&r.id!=id)
      bucket=r
      s+=1
    end

    if(sequence.nil?)
      return r!=nil ? r.value : nil
    elsif(sequence)
      return s+1
    end

  end

  def deleteValue(id)
    i=id%@size
    bucket=@array[i]
    v=nil
    while((r=bucket.next)!=nil&&r.id!=id)
      bucket=r
    end

    if((r=bucket.next)!=nil)
      v=r.value
      bucket.next=r.next
    end
    return v
  end
end

class HashTableSorted < AbstractHash
  def addValue(id,value)
    i=id%@size
    bucket=@array[i]
    v=nil
    while((r=bucket.next)!=nil&&r.id<id)
      bucket=r
    end

    if(bucket.next.nil?||bucket.next.id!=id)
      bucket.addAfterMe(id,value)
      v=value
    end
    return v
  end

  def getValue(id,sequence=nil)
    i=id%@size
    bucket=@array[i]
    s=0
    while(bucket.next!=nil&&bucket.next.id<id)
      bucket=bucket.next
      s+=1
    end

    if(sequence.nil?)
      return !bucket.next.nil?&&bucket.next.id==id ? bucket.next.value : nil
    elsif(sequence)
      return s+1
    end
  end

  def deleteValue(id)
    i=id % @size
    bucket=@array[i]
    v=nil
    while(bucket.next!=nil&&bucket.next.id<id)
      bucket=bucket.next
    end
    if(!bucket.next.nil?&&bucket.next.id==id)
      v=bucket.next.value
      bucket.next=bucket.next.next
    end
    return v
  end

end


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

# Both hash tables have similar growth rate but algorithm with sorting
# gives shorter probe sequences
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

#graphChaining


# Exercise 4
class Element
  attr_accessor :id, :value
  def initialize(id,value)
    @id=id
    @value=value
  end
end


class LinearHash
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value)
    k=id % @size
    s,v=0,nil
    duplicate=false
    while((r=@array[(k+s)%@size])!=nil&&r!=:deleted&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r==nil||r==:deleted)
      @array[(k+s)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id,sequence=nil)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    if(sequence.nil?)
      return !r.nil?&&r!=:deleted&&
              r.id==id ? r.value : nil
    elsif(sequence)
      return s+1
    end
  end


  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted&&r.id==id)
      v=r.value
      @array[(k+s)%@size]=:deleted
    end
    return v
  end

end


# Exercise 5
class QuadraticHash
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value)
    k=id % @size
    s,v=0,nil
    duplicate=false
    while((r=@array[(k+s**2)%@size])!=nil&&r!=:deleted&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r==nil||r==:deleted)
      @array[(k+s**2)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id,sequence=nil)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    if(sequence.nil?)
      return !r.nil?&&r!=:deleted&&
              r.id==id ? r.value : nil
    elsif(sequence)
      return s+1
    end
  end

  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted&&r.id==id)
      v=r.value
      @array[(k+s**2)%@size]=:deleted
    end

    return v
  end

end

# Exercise 6
class PseudorandomHash
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value)
    k=id % @size
    s,v=0,nil
    duplicate=false
    p=Random.new(k).rand(0..@size-1)
    while((r=@array[(k+s*p)%@size])!=nil&&r!=:deleted&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r==nil||r==:deleted)
      @array[(k+s*p)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id,sequence=nil)
    k=id % @size
    s,v=0,nil
    p=Random.new(k).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    if(sequence.nil?)
      return !r.nil?&&r!=:deleted&&
              r.id==id ? r.value : nil
    elsif(sequence)
      return s+1
    end
  end

  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    p=Random.new(k).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted&&r.id=id)
      v=r.value
      @array[(k+s*p)%@size]=:deleted
    end
    return v
  end
end


# Exercise 7
class DoubleHash
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value)
    k=id % @size
    s,v=0,nil
    duplicate=false
    p=Random.new(id).rand(0..@size-1)
    while((r=@array[(k+s*p)%@size])!=nil&&r!=:deleted&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r==nil||r==:deleted)
      @array[(k+s*p)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id,sequence=nil)
    k=id % @size
    s,v=0,nil
    p=Random.new(id).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    if(sequence.nil?)
      return !r.nil?&&r!=:deleted&&
              r.id==id ? r.value : nil
    elsif(sequence)
      return s+1
    end
  end

  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    p=Random.new(id).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted&&r.id==id)
      v=r.value
      @array[(k+s*p)%@size]=:deleted
    end
    return v
  end
end

# Exercise 8
# Array size N should be prime number


# Exercise 9
class OrderedQuadratic
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value)
    k=id % @size
    s,v=0,nil
    duplicate=false
    original=value
    while((r=@array[(k+s**2)%@size])!=nil&&r!=:deleted&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      if(r.id>id)
        id,r.id=r.id,id
        value,r.value=r.value,value
      end
      s+=1
    end

    if(!duplicate&&r==nil||r==:deleted)
      @array[(k+s**2)%@size] = Element.new(id,value)
      v=original
    end
    return v
  end

  def getValue(id,sequence=nil)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r!=nil&&r.id<id))&&
            s<@size-1)
      s+=1
    end
    if(sequence.nil?)
      return !r.nil?&&r!=:deleted&&
              r.id==id ? r.value : nil
    elsif(sequence)
      return s+1
    end
  end

  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r!=nil&&r.id<id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted&&r.id==id)
      v=r.value
      @array[(k+s**2)%@size]=:deleted
    end

    return v
  end

end


# Exercise 10
class OrderedDouble
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value)
    k=id % @size
    s,v=0,nil
    duplicate=false
    original=value
    p=Random.new(id).rand(0..@size-1)
    while((r=@array[(k+s*p)%@size])!=nil&&r!=:deleted&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      elsif(r.id>id)
        id,r.id=r.id,id
        value,r.value=r.value,value
        p=Random.new(id).rand(0..@size-1) # step size for larger element
        k=(k+s*p)%@size # larger element taken from this position
        s=1 # start 1*p unit from k
      else
        s+=1
      end
    end

    if(!duplicate&&r==nil||r==:deleted)
      @array[(k+s*p)%@size] = Element.new(id,value)
      v=original
    end
    return v
  end

  def getValue(id,sequence=nil)
    k=id % @size
    s,v=0,nil
    p=Random.new(id).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r.id<id))&&
            s<@size-1)
      s+=1
    end
    if(sequence.nil?)
      return !r.nil?&&r!=:deleted&&
              r.id==id ? r.value : nil
    elsif(sequence)
      return s+1
    end
  end

  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    p=Random.new(id).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r.id<id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted&&r.id==id)
      v=r.value
      @array[(k+s*p)%@size]=:deleted
    end

    return v
  end

end


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

# Main function for exercise 11
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

#graphOpenAddressing

# TESTS
# -------------------------------------------------------------------------
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

# -------------------------------------------------------------------------
hashTest(:unsorted)
hashTest(:sorted)
hashTest(:linear)
hashTest(:quadratic)
hashTest(:pseudorandom)
hashTest(:double)
hashTest(:ordered_quadratic)
hashTest(:ordered_double)
# -------------------------------------------------------------------------
