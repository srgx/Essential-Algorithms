# Exercise 2

def encipher(plaintext,rows,cols,mapping)
  ciphertext = ""
  for row in 0..rows-1
    for col in 0..cols-1
      index = row*cols + mapping[col]
      ciphertext += plaintext[index]
    end
  end
  return ciphertext
end

PT = "THISISASECRETMESSAGE"
CT = "ISITHSECSATMEREAGESS"
MP = [2,3,4,0,1] # mapping
IM = [3,4,0,1,2] # inverse mapping

t = encipher(PT,4,5,MP) # encipher
raise "Error" if t != CT
r = encipher(t,4,5,IM) # decipher
raise "Error" if r != PT
