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

  def getValue(id)
    i=id%@size
    bucket=@array[i]
    while((r=bucket.next)!=nil&&r.id!=id)
      bucket=r
    end

    result = r!=nil ? r.value : nil
    return result
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

  def getValue(id)
    i=id%@size
    bucket=@array[i]
    while(bucket.next!=nil&&bucket.next.id<id)
      bucket=bucket.next
    end

    result=!bucket.next.nil?&&bucket.next.id==id ? bucket.next.value : nil
    return result
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

  def getValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s)%@size])==:deleted)||
            (r!=nil&&r!=:deleted&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    return !r.nil?&&r!=:deleted&&
            r.id==id ? r.value : nil
  end


  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s)%@size])==:deleted)||
            (r!=nil&&r!=:deleted&&r.id!=id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted)
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

  def getValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r!=nil&&r!=:deleted&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    return !r.nil?&&r!=:deleted&&
            r.id==id ? r.value : nil
  end

  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r!=nil&&r!=:deleted&&r.id!=id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted)
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

  def getValue(id)
    k=id % @size
    s,v=0,nil
    p=Random.new(k).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r!=:deleted&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    return !r.nil?&&r!=:deleted&&
            r.id==id ? r.value : nil
  end

  def deleteValue(id)
    k=id % @size
    s,v=0,nil
    p=Random.new(k).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r!=:deleted&&r.id!=id))&&
            s<@size-1)
      s+=1
    end

    if(!r.nil?&&r!=:deleted)
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

  def getValue(id)
    k=id % @size
    s,v=0,nil
    p=Random.new(id).rand(0..@size-1)
    while((((r=@array[(k+s*p)%@size])==:deleted)||
            (r!=nil&&r.id!=id))&&
            s<@size-1)
      s+=1
    end
    return !r.nil?&&r!=:deleted&&
            r.id==id ? r.value : nil
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

  def getValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r!=nil&&r.id<id))&&
            s<@size-1)
      s+=1
    end
    return !r.nil?&&r!=:deleted&&
            r.id==id ? r.value : nil
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
# ...
class OrderedDouble
  attr_reader :array
  def initialize(size)
    @size=size
    @array=Array.new(size)
  end

  def addValue(id,value)
  end

end


ERR="Error"
# -------------------------------------------------------------------------
def hashTest(type)
  s=15
  hashTypes=
    { sorted: HashTableSorted,
      unsorted: HashTable,
      linear: LinearHash,
      quadratic: QuadraticHash,
      pseudorandom: PseudorandomHash,
      double: DoubleHash,
      ordered_quadratic: OrderedQuadratic }

  h=hashTypes[type].new(s)

  # ADD VALUES
  raise ERR if(h.addValue(95,"A")!="A")
  raise ERR if(h.addValue(65,"B")!="B")
  raise ERR if(h.addValue(65,"Duplicate")!=nil)
  raise ERR if(h.addValue(25,"C")!="C")
  raise ERR if(h.addValue(121,"D")!="D")
  raise ERR if(h.addValue(83,"E")!="E")

  # DELETE VALUES
  raise ERR if(h.deleteValue(95)!="A")
  raise ERR if(h.deleteValue(65)!="B")
  raise ERR if(h.deleteValue(35)!=nil)

  # GET VALUES
  raise ERR if(h.getValue(25)!="C")
  raise ERR if(h.getValue(121)!="D")
  raise ERR if(h.getValue(83)!="E")
  raise ERR if(h.getValue(65)!=nil)
  raise ERR if(h.getValue(63)!=nil)
  raise ERR if(h.getValue(95)!=nil)

end
# -------------------------------------------------------------------------
hashTest(:unsorted)
hashTest(:sorted)
hashTest(:linear)
hashTest(:quadratic)
hashTest(:pseudorandom)
hashTest(:double)
hashTest(:ordered_quadratic)
# -------------------------------------------------------------------------
