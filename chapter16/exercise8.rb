require_relative 'exercise6.rb'
# Exercise 8

PLUS = lambda {|x,y| x + y }
MINUS = lambda {|x,y| x - y }

def hVigen(text,key,s)
  result = ""
  skip = 0
  for i in 0..text.size-1
    if((indx=LETTERS.index(text[i])).nil?)
      result += " "
      skip+=1
    else
      shift = LETTERS.index(key[(i-skip)%key.size])
      index = (s.call(indx,shift)) % LETTERS.size
      result += LETTERS[index]
    end
  end
  return result
end

def encipherVigenere(text,key)
  hVigen(text,key,PLUS)
end

def decipherVigenere(text,key)
  hVigen(text,key,MINUS)
end

key = "VIGENERE"
cp = "VDOKRRVVZKOTUIIMNUUVRGFQKTOGNXVHOPGRPEVWVZYYOWKMOCZMBR"
pt = "AVIGENERECIPHERISMORECOMPLICATEDTHANCAESARSUBSTITUTION"
raise "Error" if decipherVigenere(cp,key) != pt
raise "Error" if encipherVigenere(pt,key) != cp
