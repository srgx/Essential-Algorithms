require_relative 'exercise22.rb'
# Exercise 23

def nonRecFiboLast(n)
  s, b, result = 0, 1, 0
  2.upto(n) do |i|
    result = s + b
    s, b = b, result
  end
  return result
end

def testFibos(n,tests)
  initFibo
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  tests.times { fibo(n) }
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Fibo1: #{ending-starting}"


  initFibo
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  tests.times { nonRecFibo(n) }
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Fibo2: #{ending-starting}"

  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  tests.times { nonRecFiboLast(n) }
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "Fibo3: #{ending-starting}"
end

# testFibos(1000,1000)
