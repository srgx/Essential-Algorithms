# Exercise 21

class AnimalNode
  attr_accessor :question, :yes, :no
  def initialize(text)
    @question = text
  end
end


start = AnimalNode.new("Is it a mammal?")
bark = AnimalNode.new("Does it bark?")
scales = AnimalNode.new("Does it have scales?")
start.yes, start.no = bark, scales
bark.yes = AnimalNode.new("dog")
bark.no = AnimalNode.new("cat")
breathe =  AnimalNode.new("Does it breathe water?")
breathe.yes = AnimalNode.new("fish")
breathe.no = AnimalNode.new("snake")
scales.yes = breathe
scales.no = AnimalNode.new("bird")

def getAns
  ans = gets.chomp
  while(ans!="y"&&ans!="n")
    print "Answer y or n: "
    ans = gets.chomp
  end
  return ans
end


def playGame(start)
  pt, parent = start, nil
  while(!pt.yes.nil?)
    print "#{pt.question}: "
    ans = getAns

    parent = pt
    if(ans=="y")
      pt = pt.yes
    elsif(ans=="n")
      pt = pt.no
    end
  end

  print "Is it a #{pt.question}?: "
  ans = getAns

  if(ans=="y")
    puts "Success!"
  elsif(ans=="n")
    print "What is your animal?: "
    animal = gets.chomp

    print "Question to differentiate between #{pt.question} and #{animal}?: "
    question = gets.chomp

    print "Is the answer for this question true for a #{animal}?: "
    qAns = getAns

    # create node for new question
    newQ = AnimalNode.new(question)
    newAnimal = AnimalNode.new(animal)

    # set new question answers
    if(qAns=="y")
      newQ.no, newQ.yes = pt, newAnimal
    elsif(qAns=="n")
      newQ.no, newQ.yes = newAnimal, pt
    end

    # replace wrong animal with new question
    if(parent.yes==pt)
      parent.yes = newQ
    elsif(parent.no==pt)
      parent.no = newQ
    end
  end
end

loop do
  playGame(start)
  print "Do you want to play again?: "
  ans = gets.chomp
  break if ans=="n"
end
