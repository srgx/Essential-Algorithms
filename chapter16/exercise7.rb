require_relative 'exercise6.rb'
# Exercise 7

def findLetter(ltrs,l)
  for i in 0...ltrs.size
    if(ltrs[i][0]==l)
      return i
    end
  end
  return -1
end

def findOffsetFromE(letter)
  letter = letter.upcase
  eIndex = LETTERS.index("E")
  lIndex = LETTERS.index(letter)
  return (lIndex - eIndex) % LETTERS.size
end

def showOffsetsFromE(letters)
  letters.each do | l |
    ll = l[0]
    offset = findOffsetFromE(ll)
    puts "#{ll} - #{offset}"
  end
end


def frequencies(message)
  message, letters = message.upcase, Array.new
  for i in 0...message.size
    l = message[i]
    if(!LETTERS.include?(l)) then next end
    if((indx=findLetter(letters,l))>=0)
      letters[indx][1]+=1
    else
      letters << [l,1]
    end
  end
  return letters
end

msg = "KYVIV NRJRK ZDVNY VETRV JRIJL SJKZK LKZFE NRJKY VJKRK VFWKY VRIK."

freqs = frequencies(msg)
freqs = freqs.sort_by{ |fr| fr[1] }.reverse

# showOffsetsFromE(freqs)

# 17 is second candidate
# puts caesar(msg,-17)
