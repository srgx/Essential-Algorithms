require_relative 'exercise3.rb'
# Exercise 4

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class Point
  attr_accessor :x, :y
  def initialize(x=0,y=0)
    @x=x
    @y=y
  end
end

class Disk
  attr_accessor :width, :height, :position
  def initialize(width=500,height=50)
    @width,@height = width,height
    @position = nil
  end

  def render
    Rectangle.new(
      x: @position.x, y: @position.y,
      width: @width, height: @height,
      color: 'blue',
      z: 15
    )
  end
end

class Peg
  def initialize(width,height,position)
    @disks = Array.new
    @width, @height = width, height
    @position = position
    @space = 5
  end

  def addDisk(disk)
    c,dh = self.number_of_disks, disk.height
    x = @position.x-(disk.width-@width)/2.0
    y = @position.y+@height-(c+1)*dh-c*@space
    disk.position = Point.new(x,y)
    @disks.push(disk)
  end

  def render
    Rectangle.new(
      x: @position.x, y: @position.y,
      width: @width, height: @height,
      color: 'red',
      z: 20
    )
    @disks.each { | d | d.render }
  end

  def number_of_disks
    return @disks.size
  end

  def popDisk
    return @disks.pop
  end
end

class Game
  def initialize(solution,discs)
    @solution = solution
    @pegs = Array.new(3)
    @distance = 550 # distance between pegs
    @first_peg_x = 350
    @peg_y = 200
    @peg_width, @peg_height = 30, 600
    @step_counter=0

    0.upto(@pegs.size-1) do |i|
      position = Point.new(@first_peg_x+i*@distance,@peg_y)
      @pegs[i] = Peg.new(@peg_width,@peg_height,position)
    end

    sz = 400
    discs.times do
      @pegs[0].addDisk(Disk.new(sz))
      sz-=80
    end
  end

  def render
    @pegs.each do |p|
      p.render
    end
  end

  def moveDisk(from,to)
    from, to = @pegs[from], @pegs[to]
    d = from.popDisk
    to.addDisk(d)
  end

  def update
    if(!@solution[@step_counter].nil?)
      from = @solution[@step_counter][0]
      to = @solution[@step_counter][1]
      self.moveDisk(from,to)
      @step_counter+=1
    end
  end
end

def startHanoi(discs)
  game = Game.new(hanoi(0,2,1,discs,[]),discs)
  game.render

  tick=1
  update do
    if tick % 60 == 0
      game.update
      clear
      game.render
    end
    tick += 1
  end
  show
end

# startHanoi 3
