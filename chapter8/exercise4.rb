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
