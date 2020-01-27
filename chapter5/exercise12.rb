require_relative 'exercise11.rb'
# Exercise 12

def queueSelectionSort(top,bot)
  r=createTemp
  top_temp,bot_temp=r[0],r[1]
  num_items=queueSize(top)
  0.upto(num_items-1) do |i|
    max=dequeueFromBot(bot)
    (num_items-i-1).times do
      v=dequeueFromBot(bot)
      if(v>max)
        enqueueAfter(top,max)
        max=v
      else
        enqueueAfter(top,v)
      end
    end
    enqueueAfter(top_temp,max)
  end

  while((v=dequeueFromBot(bot_temp))!=:empty)
    enqueueAfter(top,v)
  end
end


topSentinel=DoubleCell.new
bottomSentinel=DoubleCell.new
topSentinel.next=bottomSentinel
bottomSentinel.prev=topSentinel
[5,2,7,4,1,6,3].each { |i| enqueueAfter(topSentinel,i)}
queueSelectionSort(topSentinel,bottomSentinel)
7.downto(1) { |i| raise ERR if(dequeueFromBot(bottomSentinel)!=i) }
