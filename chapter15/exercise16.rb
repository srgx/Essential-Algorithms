# Exercise 16

# Choose path with largest number of diagonals.
# For figure 15-13 true edit distance is 5.

# assent -> descent

# h - horizontal, v - vertical, d - diagonal

# h(1) -> ssent -> remove 'a'
# v(1) -> dssent -> add 'd'
# v(1) -> dessent -> add 'e'
# d(0) -> dessent -> ---
# h(1) -> desent -> remove 's'
# v(1) -> descent -> add 'c'
# d(0) -> descent -> ---
# d(0) -> descent -> ---
# d(0) -> descent -> ---
