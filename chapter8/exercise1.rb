# Exercise 1

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
