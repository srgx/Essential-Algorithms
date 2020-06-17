# Exercise 10

# A - Source, I - Sink

# Flow/Capacity

#  A -- 4/4 --> B -- 1/2 --> C
#  |            |            |
# 2/4          3/4          1/2
#  |            |            |
#  D -- 1/1 --> E -- 2/2 --> F
#  |            |            |
# 1/3          2/2          3/5
#  |            |            |
#  G -- 1/4 --> H -- 3/3 --> I


# Residual Capacity Network

# Forward|Backward

#  A -- 0|4 --> B -- 1|1 --> C
#  |            |            |
# 2|2          1|3          1|1
#  |            |            |
#  D -- 0|1 --> E -- 0|2 --> F
#  |            |            |
# 2|1          0|2          2|3
#  |            |            |
#  G -- 3|1 --> H -- 0|3 --> I

# Path
# A -> D -> G -> H -> E -> B -> C -> F -> I

# Smallest residual capacity of link or backlink in path: 1

# Update Path

# A -> D, +1
# D -> G, +1
# G -> H, +1
# H -> E, -1
# E -> B, -1
# B -> C, +1
# C -> F, +1
# F -> I, +1

# New Flow

#  A -- 4/4 --> B -- 2/2 --> C
#  |            |            |
# 3/4          2/4          2/2
#  |            |            |
#  D -- 1/1 --> E -- 2/2 --> F
#  |            |            |
# 2/3          1/2          4/5
#  |            |            |
#  G -- 2/4 --> H -- 3/3 --> I


# Total Flow - 7
# Max Total Flow - 7
