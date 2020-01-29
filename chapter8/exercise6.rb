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
