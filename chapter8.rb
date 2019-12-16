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
    while((r=@array[(k+s)%@size]).class==Element&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r.class!=Element)
      @array[(k+s)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s)%@size])==:deleted)||
            (r.class==Element&&r.id!=id))&&
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
            (r.class==Element&&r.id!=id))&&
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
    while((r=@array[(k+s**2)%@size]).class==Element&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r.class!=Element)
      @array[(k+s**2)%@size] = Element.new(id,value)
      v=value
    end
    return v
  end

  def getValue(id)
    k=id % @size
    s,v=0,nil
    while((((r=@array[(k+s**2)%@size])==:deleted)||
            (r.class==Element&&r.id!=id))&&
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
            (r.class==Element&&r.id!=id))&&
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
    while((r=@array[(k+s*p)%@size]).class==Element&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r.class!=Element)
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
            (r.class==Element&&r.id!=id))&&
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
            (r.class==Element&&r.id!=id))&&
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
    while((r=@array[(k+s*p)%@size]).class==Element&&s<@size-1)
      if(r.id==id)
        duplicate=true
        break
      end
      s+=1
    end

    if(!duplicate&&r.class!=Element)
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
            (r.class==Element&&r.id!=id))&&
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
            (r.class==Element&&r.id!=id))&&
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

ERR="Error"
# -------------------------------------------------------------------------
def hashTest(type)
  s=50
  h=case type
  when :sorted
    HashTableSorted.new(s)
  when :unsorted
    HashTable.new(s)
  when :linear
    LinearHash.new(s)
  when :quadratic
    QuadraticHash.new(s)
  when :pseudorandom
    PseudorandomHash.new(s)
  when :double
    DoubleHash.new(s)
  end

  # ADD VALUES
  raise ERR if(h.addValue(35,"Frodo")!="Frodo")
  raise ERR if(h.addValue(65,"Gandalf")!="Gandalf")
  raise ERR if(h.addValue(16,"Pippin")!="Pippin")
  # DUPLICATE
  raise ERR if(h.addValue(35,"Bilbo")!=nil)
  # PRESENCE
  raise ERR if(h.getValue(35)!="Frodo")
  raise ERR if(h.getValue(65)!="Gandalf")
  raise ERR if(h.getValue(16)!="Pippin")
  # DELETION
  raise ERR if(h.deleteValue(88)!=nil)
  raise ERR if(h.deleteValue(65)!="Gandalf")
  # ABSENCE
  raise ERR if(h.getValue(65)!=nil)
  raise ERR if(h.getValue(99)!=nil)
end
# -------------------------------------------------------------------------
hashTest(:unsorted)
hashTest(:sorted)
hashTest(:linear)
hashTest(:quadratic)
hashTest(:pseudorandom)
hashTest(:double)
# -------------------------------------------------------------------------
