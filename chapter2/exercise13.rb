# Exercise 13
# Start loop with current_prime**2, all smaller multiplies have already been marked
module Algorithm
  def Algorithm.sieve(n)
    is_composite = Array.new(n+1,false)
    (4..n).step(2) do |i|
      is_composite[i] = true
    end

    current_prime = 3
    stop_at = Integer.sqrt(n)

    while(current_prime <= stop_at)
      (current_prime**2..n).step(current_prime) { |i| is_composite[i] = true }

      #current_prime+=2
      #while((current_prime<=n)&&(is_composite[current_prime]))
      #  current_prime+=2
      #end

      loop do
        current_prime+=2
        break if(!((current_prime<=n)&&(is_composite[current_prime])))
      end

    end

    primes = []
    2.upto(n) do |i|
      if(!is_composite[i]) then primes << i end
    end

    return primes
  end
end

PRIMES=[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]

if(Algorithm.sieve(50)!=PRIMES) then raise "Error" end
