require_relative 'exercise1.rb'
# Exercise 2

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
