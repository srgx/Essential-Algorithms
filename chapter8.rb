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
  def addValue(id,value) # return Answer.new(value|nil,probes)
    res,v=self.getValue(id),nil
    unless(res.result!=nil)
      i=id%@size
      @array[i].addAfterMe(id,value)
      v=value
    end

    return Answer.new(v,res.probes)
  end

  def getValue(id) # return Answer.new(value|nil,probes)
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

  def deleteValue(id) # return value|nil
    i=id%@size
    bucket=@array[i]
    v=nil
    while(bucket.next!=nil&&bucket.next.id!=id)
      bucket=bucket.next
    end

    if(bucket.next!=nil)
      v=bucket.next.value
      bucket.next=bucket.next.next
    end
    return v
  end
end

class HashTableSorted < AbstractHash
  def addValue(id,value) # return Answer.new(value|nil,probes)
    i=id%@size
    bucket=@array[i]
    p,v=0,nil
    while(bucket.next!=nil&&bucket.next.id<id)
      bucket=bucket.next
      p+=1
    end

    if(bucket.next.nil?||bucket.next.id!=id)
      bucket.addAfterMe(id,value)
      v=value
    end
    return Answer.new(v,p)
  end

  def getValue(id) # return Answer.new(value|nil,probes)
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

  def deleteValue(id) # return value|nil
    i=id%@size
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


def hashTest(elements,type)
  h = type=="sorted" ? HashTableSorted.new(10) : HashTable.new(10)
  probes=0
  elements.times do
    v=rand(100000)
    r=h.addValue(v,v.to_s)
    probes+=r.probes
  end
  average=probes/elements.to_f
  puts "Average #{type} set probes #{average}"
  probes=0
  1000.times do
    v=rand(100000)
    r=h.getValue(v)
    probes+=r.probes
  end
  average=probes/1000.to_f
  puts "Average #{type} get probes #{average}"
end


# Show number of probes
#hashTest(250,"sorted")
#hashTest(250,"unsorted")


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

  def addValue(id,value) # return value|nil
    k=id % @size # first choice
    s,v=0,nil
    duplicate=false
    while(!@array[(k+s)%@size].nil?&&s<@size-1)
      if(@array[(k+s)%@size].id==id)
        duplicate=true
        break
      end
      s+=1
    end
    if(@array[(k+s)%@size].nil?&&!duplicate)
      @array[(k+s)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id) # return value|nil
    k=id % @size # first choice
    s,v=0,nil
    while(!@array[(k+s)%@size].nil?&&s<@size-1&&@array[(k+s)%@size].id!=id)
      s+=1
    end
    return !@array[(k+s)%@size].nil?&&@array[(k+s)%@size].id==id ? @array[(k+s)%@size].value : nil
  end
end


# Exercise 5
class QuadraticHash
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value) # return value|nil
    k=id % @size # first choice
    s,v=0,nil
    duplicate=false
    while(!@array[(k+s**2)%@size].nil?&&s<@size-1)
      if(@array[(k+s**2)%@size].id==id)
        duplicate=true
        break
      end
      s+=1
    end
    if(@array[(k+s**2)%@size].nil?&&!duplicate)
      @array[(k+s**2)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id) # return value|nil
    k=id % @size # first choice
    s,v=0,nil
    while(!@array[(k+s**2)%@size].nil?&&s<@size-1&&@array[(k+s**2)%@size].id!=id)
      s+=1
    end
    return !@array[(k+s**2)%@size].nil?&&@array[(k+s**2)%@size].id==id ? @array[(k+s**2)%@size].value : nil
  end

end

# Exercise 6
# ...


ERR="Error"
# -------------------------------------------------------------------------
h=HashTable.new(10)
h.addValue(1,"Frodo")
if(h.addValue(12,"Sauron").result!="Sauron") then raise ERR end
if(h.addValue(12,"Gandalf").result!=nil) then raise ERR end
h.addValue(34,"Sam")
h.addValue(32,"Saruman")
if(h.deleteValue(33)!=nil) then raise ERR end
if(h.getValue(12).result!="Sauron") then raise ERR end
if(h.getValue(34).result!="Sam") then raise ERR end
if(h.deleteValue(12)!="Sauron") then raise ERR end
if(h.getValue(12).result!=nil) then raise ERR end
if(h.getValue(34).result!="Sam") then raise ERR end
if(h.getValue(32).result!="Saruman") then raise ERR end
# -------------------------------------------------------------------------
h=HashTableSorted.new(10)
h.addValue(1,"Frodo")
if(h.addValue(12,"Sauron").result!="Sauron") then raise ERR end
if(h.addValue(12,"Gandalf").result!=nil) then raise ERR end
h.addValue(34,"Sam")
h.addValue(32,"Saruman")
if(h.deleteValue(33)!=nil) then raise ERR end
if(h.getValue(12).result!="Sauron") then raise ERR end
if(h.getValue(34).result!="Sam") then raise ERR end
if(h.deleteValue(12)!="Sauron") then raise ERR end
if(h.getValue(12).result!=nil) then raise ERR end
if(h.getValue(34).result!="Sam") then raise ERR end
if(h.getValue(32).result!="Saruman") then raise ERR end
# -------------------------------------------------------------------------
h=LinearHash.new(5)
h.addValue(2,"Pippin")
h.addValue(42,"Merry")
if(h.addValue(42,"DuplicateMerry")!=nil) then raise ERR end
h.addValue(74,"Balrog")
h.addValue(124,"Gimli")
if(h.addValue(92,"Smaug")!="Smaug") then raise ERR end
if(h.addValue(123,"Boromir")!=nil) then raise ERR end
if(h.getValue(124)!="Gimli") then raise ERR end
if(h.getValue(42)!="Merry") then raise ERR end
if(h.getValue(999)!=nil) then raise ERR end
# -------------------------------------------------------------------------
h=QuadraticHash.new(5)
h.addValue(2,"Pippin")
h.addValue(42,"Merry")
if(h.addValue(42,"DuplicateMerry")!=nil) then raise ERR end
h.addValue(74,"Balrog")
h.addValue(124,"Gimli")
if(h.addValue(92,"Smaug")!="Smaug") then raise ERR end
if(h.addValue(123,"Boromir")!=nil) then raise ERR end
if(h.getValue(124)!="Gimli") then raise ERR end
if(h.getValue(42)!="Merry") then raise ERR end
if(h.getValue(999)!=nil) then raise ERR end
# -------------------------------------------------------------------------
