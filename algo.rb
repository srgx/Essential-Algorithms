def containsDuplicates(array)
	0.upto(array.size-1) do |i|
		0.upto(array.size-1) do |j|
			if(i!=j)
				if(array[i] == array[j]) then return true end
			end
		end
	end
	return false
end

def containsDuplicates2(array)
	0.upto(array.size-2) do |i|
		(i+1).upto(array.size-1) do |j|
			if(array[i] == array[j]) then return true end
		end
	end
	return false
end

err = "ERROR"

noDups = [12,33,4,7,99]
dups = [12,33,4,7,4,99]

if containsDuplicates(noDups) then raise err end
if !containsDuplicates(dups) then raise err end
if containsDuplicates2(noDups) then raise err end
if !containsDuplicates2(dups) then raise err end

# Exercise 1
# Runtime is O(N^2)

# Exercise 2
stepsPerSecond = 1000000
stepsPerMinute = stepsPerSecond * 60
stepsPerHour = stepsPerMinute * 60
stepsPerDay = stepsPerHour * 24
stepsPerWeek = stepsPerDay * 7
stepsPerYear = stepsPerDay * 365

# n!
# second: 9, minute: 11, hour: 12, day: 13, week: 14, year: 16

# 2^n
# second: 19, minute: 25, hour: 31, day: 36, week: 39, year: 44

# n^2
# second: 1000, minute: 7745, hour: 60000, day: 293938, week: 777688, year: 5615692

# n
# second: 1000.000, minute: 60.000.000, hour: 3600.000.000, day: 86400.000.000
# week: 604800.000.000, year: 31536.000.000.000


