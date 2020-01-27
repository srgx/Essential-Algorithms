# Exercise 6

def caesar(plaintext,n)
  ciphertext = ""
  for i in 0..plaintext.size-1 do
    index = LETTERS.index(plaintext[i].upcase)
    if(index.nil?)
      ciphertext += " "
    else
      index = (index + n) % LETTERS.size
      ciphertext += LETTERS[index]
    end
  end
  return ciphertext
end


LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

t = caesar("hello world",28) # +2

raise "Error" if t != "JGNNQ YQTNF"
