require_relative '../chapter2/exercise9.rb'
# Exercise 15
p = 107
q = 211
e = 4199

n = lcm(p,q) # least common multiple
fiN = (p-1)*(q-1) # 22260
d = 18899 # ModularMultiplicativeInverse of e and fiN


# encryption of 1337 = 13400
encrypted = (1337**e)%n

# decryption of 19905 = 12345
decrypted = 19905**d%n

# puts "Encrypted #{encrypted}"
# puts "Decrypted #{decrypted}"

raise "Error" if encrypted != 13400
raise "Error" if decrypted != 12345
