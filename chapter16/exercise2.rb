# Exercise 2

def encipherCols(plaintext,rows,cols,mapping)
  ciphertext = ""
  for row in 0..rows-1
    for col in 0..cols-1
      index = row*cols + mapping[col]
      ciphertext += plaintext[index]
    end
  end
  return ciphertext
end

def createMapping(word)
  w = word.upcase
  sorted = w.chars.sort
  mapping = Array.new(word.size)
  for i in 0..w.size-1
    mapping[i] = sorted.index(w[i])
  end
  return mapping
end

def inverseMapping(m)
  newMapping = Array.new(m.size)
  for i in 0..m.size-1
    newMapping[m[i]] = i
  end
  return newMapping
end

ERR = "Error"

PT = "THISISASECRETMESSAGE"
CT = "ISITHSECSATMEREAGESS"
key = "SUWAK"
MP = createMapping(key) # [2,3,4,0,1], col mapping
IM = inverseMapping(MP)

t = encipherCols(PT,4,5,MP) # encipher
raise "Error" if t != CT
r = encipherCols(t,4,5,IM) # decipher
raise "Error" if r != PT
