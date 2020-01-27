require_relative 'exercise2.rb'
# Exercise 2

def encipherRows(plaintext,rows,cols,mapping)
  ciphertext = ""
  for row in 0..rows-1
    for col in 0..cols-1
      index = cols*mapping[row] + col
      ciphertext += plaintext[index]
    end
  end
  return ciphertext
end


RMP = createMapping("WODE") # [3,2,0,1] # row mapping
IRMP = inverseMapping(RMP)

# encipher
t = encipherCols(PT,4,5,MP) # ISITH SECSA TMERE AGESS
t = encipherRows(t,4,5,RMP) # AGESS TMERE ISITH SECSA
raise ERR if t!="AGESSTMEREISITHSECSA"

# decipher
t = encipherRows(t,4,5,IRMP)
t = encipherCols(t,4,5,IM)
raise ERR if t!= PT
