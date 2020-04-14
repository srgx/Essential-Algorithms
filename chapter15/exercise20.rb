# Exercise 20

# print "File1: "
# file1 = gets.chomp
#
# print "File2: "
# file2 = gets.chomp

file1 = "file1.txt"
file2 = "file2.txt"

puts "File1: #{file1}"
puts "File2: #{file2}"


string1 = File.read(file1)
string2 = File.read(file2)

puts "String1: #{string1}"
puts "String2: #{string2}"
