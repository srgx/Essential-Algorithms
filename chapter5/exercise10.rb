# Exercise 10

class Customer
  attr_reader :id, :waiting
  def initialize(id)
    @id=id
    @waiting=0
  end

  def update
    @waiting+=1
  end
end

class Teller
  def initialize(id,client_time)
    @id=id
    @left=0
    @client_time=client_time
  end

  def process(client)
    puts "Hello, Sir #{client.id}! I'm teller #{@id}."
    puts "You have been waiting #{client.waiting} minutes!"
    @left=@client_time
  end

  def update
    if (@left>0) then @left-=1 end
  end

  def free?
    return @left==0
  end
end

class Bank
  def initialize(tellers,client_time)
    @time=1
    @tellers=[]
    tellers.times { |i| @tellers << Teller.new(i,client_time) }
    @queue=[]
  end

  def getFreeTellers
    result=[]
    @tellers.each do |teller|
      if(teller.free?)
        result << teller
      end
    end
    return result
  end

  def update
    if(@time%3==0) then @queue << Customer.new(@time) end

    freeTellers=self.getFreeTellers
    freeTellers.each do |tlr|
      client=@queue.shift
      if(!client.nil?) then tlr.process(client) end
    end

    @tellers.each { |t| t.update }
    @queue.each { |c| c.update }

    puts "Time: #{@time}, Size: #{@queue.size}"
    @time+=1
    sleep(0.1)
  end
end

def bankSimulation
  bank=Bank.new(5,15) # tellers, time per client
  while(true)
    bank.update
  end
end
