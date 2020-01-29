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
