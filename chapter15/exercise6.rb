require_relative 'exercise2.rb'
# Exercise 6

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080


# Example expressions:
# "12"
# "7*X"
# "50*sin(X/25)"
# "(50*sin(X/25))+(20*sin(X/30))"

def main
  print "Enter expression: "
  exp = gets.chomp
  parsed = parse(exp)

  for x in 0..1500
    y = parsed.evaluate([["X",x]])
    Rectangle.new(
      x: x+100, y: y+300,
      width: 2, height: 2,
      color: 'red',
      z: 20
    )
  end

  show
end

# main
