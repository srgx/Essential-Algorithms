# Exercise 1

def encipher(plaintext,rows,cols)
  ciphertext = ""
  for col in 0..cols-1
    index = col
    for row in 0..rows-1
      ciphertext += plaintext[index]
      index += cols
    end
  end
  return ciphertext
end

def decipher(ciphertext,rows,cols)
  return encipher(ciphertext,cols,rows)
end

PLAINTEXT = "THISISASECRETMESSAGE"
CIPHERTEXT = "TSRSHAESISTASEMGICEE"

raise "Error" unless encipher(PLAINTEXT,4,5) == CIPHERTEXT
raise "Error" unless decipher(CIPHERTEXT,4,5) == PLAINTEXT
