require_relative 'exercise9.rb'
# Exercise 11

def createTemp
  top_temp=DoubleCell.new
  bot_temp=DoubleCell.new
  top_temp.next=bot_temp
  bot_temp.prev=top_temp
  return [top_temp,bot_temp]
end

def queueSize(top)
  s=0
  while(top.next.value!=nil)
    s+=1
    top=top.next
  end
  return s
end

def queueInsertionSort(top,bot)
  r=createTemp
  top_temp,bot_temp=r[0],r[1]
  num_items=queueSize(top)
  next_item=dequeueFromBot(bot)
  1.upto(num_items-1) { enqueueAfter(top_temp,dequeueFromBot(bot)) }
  while(next_item!=:empty) do
    s,set=queueSize(top),false
    0.upto(s-1) do
      v=dequeueFromBot(bot)
      if(next_item>v&&!set)
        enqueueAfter(top,next_item)
        enqueueAfter(top,v)
        set=true
      else
        enqueueAfter(top,v)
      end
    end
    if(!set) then enqueueAfter(top,next_item) end
    next_item=dequeueFromBot(bot_temp)
  end
end


topSentinel=DoubleCell.new
bottomSentinel=DoubleCell.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel
[5,2,7,4,1,6,3].each { |i| enqueueAfter(topSentinel,i)}
queueInsertionSort(topSentinel,bottomSentinel)
7.downto(1) { |i| raise ERR if(dequeueFromBot(bottomSentinel)!=i) }
