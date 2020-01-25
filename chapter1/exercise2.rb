# Exercise 2

STEPS_PER_SECOND = 1000000
STEPS_PER_MINUTE = STEPS_PER_SECOND * 60
STEPS_PER_HOUR = STEPS_PER_MINUTE * 60
STEPS_PER_DAY = STEPS_PER_HOUR * 24
STEPS_PER_WEEK = STEPS_PER_DAY * 7
STEPS_PER_YEAR = STEPS_PER_DAY * 365

# n!
# second: 9, minute: 11, hour: 12, day: 13, week: 14, year: 16

# 2^n
# second: 19, minute: 25, hour: 31, day: 36, week: 39, year: 44

# n^2
# second: 1000, minute: 7745, hour: 60000, day: 293938, week: 777688, year: 5615692

# n
# second: 1000.000, minute: 60.000.000, hour: 3600.000.000, day: 86400.000.000,
# week: 604800.000.000, year: 31536.000.000.000

# sqrt(n)
# second: 1000.000.000.000, minute: 3600.000.000.000.000, hour: 12960.000.000.000.000.000,
# day: 7464960.000.000.000.000.000, week: 365783040.000.000.000.000.000,
# year: 994519296.000.000.000.000.000.000

# log 2 n
# second: 2**STEPS_PER_SECOND, minute: 2**STEPS_PER_MINUTE, hour: 2**STEPS_PER_HOUR,
# day: 2**STEPS_PER_DAY, week: 2**STEPS_PER_WEEK, year: 2**STEPS_PER_YEAR
