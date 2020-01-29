require_relative 'exercise8.rb'
# Exercise 12

def makePad(size)
  pad = Array.new
  size.times { pad << rand(0..25) }
  return pad
end

def cryH(text,pad,position,s)
  result = ""
  skip = 0
  for i in 0..text.size-1
    if((index = LETTERS.index(text[i].upcase)).nil?)
      result += " "
      skip +=1
    else
      shift = pad[i+position-skip]
      newIndex = (s.call(index,shift)) % LETTERS.size
      result += LETTERS[newIndex]
    end
  end
  return result
end

def encrypt(text,pad,position)
  cryH(text,pad,position,PLUS)
end

def decrypt(text,pad,position)
  cryH(text,pad,position,MINUS)
end


pad = makePad(50)

message1 = "czesc kolego"
position = 0
encrypted =  encrypt(message1,pad,position)
decrypted = decrypt(encrypted,pad,position)
raise "Error" if decrypted != message1.upcase

position += message1.size
message2 = "co slychac"
encrypted =  encrypt(message2,pad,position)
decrypted = decrypt(encrypted,pad,position)
raise "Error" if decrypted != message2.upcase
