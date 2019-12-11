# Exercises 1, 2, 3
# Sorted hash tables with chaining have shorter average probe lengths

class Answer
  attr_accessor :result, :probes
  def initialize(result,probes)
    @result=result
    @probes=probes
  end
end


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
      @array[i]=Cell.new # set sentinels
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
    res=self.getValue(id) # answer
    unless(res.result!=nil)
      i=id%@size
      @array[i].addAfterMe(id,value)
    else
      puts "Duplicate key"
    end
    
    return Answer.new(nil,res.probes)
  end
  
  def getValue(id)
    i=id%@size
    bucket=@array[i]
    p=0
    while(bucket.next!=nil&&bucket.next.id!=id)
      bucket=bucket.next
      p+=1
    end
    
    result = bucket.next!=nil ? bucket.next.value : nil
    return Answer.new(result,p)
  end
end

class HashTableSorted < AbstractHash
  def addValue(id,value)
    i=id%@size
    bucket=@array[i]
    p=0
    while(bucket.next!=nil&&bucket.next.id<id)
      bucket=bucket.next
      p+=1
    end
    
    
    if(bucket.next.nil?||bucket.next.id!=id)
      bucket.addAfterMe(id,value)
    else
      puts "Duplicate key"
    end
    return Answer.new(nil,p)
  end
  
  def getValue(id)
    i=id%@size
    bucket=@array[i]
    p=0
    while(bucket.next!=nil&&bucket.next.id<id)
      bucket=bucket.next
      p+=1
    end
    
    result=!bucket.next.nil?&&bucket.next.id==id ? bucket.next.value : nil
    return Answer.new(result,p)
  end
  
end


def hashTest(elements,type)
  h = type=="sorted" ? HashTableSorted.new(10) : HashTable.new(10)
  probes=0
  elements.times do
    v=rand(100000)
    r=h.addValue(v,v.to_s)
    probes+=r.probes
  end
  average=probes/100.to_f
  puts "Average #{type} set probes #{average}"
  probes=0
  1000.times do
    v=rand(100000)
    r=h.getValue(v)
    probes+=r.probes
  end
  average=probes/100.to_f
  puts "Average #{type} get probes #{average}"
end


#hashTest(250,"sorted")
#hashTest(250,"unsorted")

# Exercise 4
# ...


