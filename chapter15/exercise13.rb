# Exercise 13

# (AB*)|(BA*)

# Parse Tree

#           (|)
#         /     \
#       (+)      (+)
#      /   \     /   \
#    (A)  (*)  (B)   (*)
#          |          |
#         (B)        (A)


#  NFA Network

# (SubMachine1 | SubMachine2)

#             0
#         o/       \o
#  SubMachine1    SubMachine2
#         o\        /o
#             Final


# SubMachine1

# (A + B*)

#   0
#   |A    # A
#   1

#   |o    # +

#   2
#   |B    # B*
#   3

# SubMachine2

# (B + A*)

#   0
#   |B    # B
#   1

#   |o    # +

#   2
#   |A    # A*
#   3


# A* and B* have links:
# 2 -> 3 (o)
# 3 -> 2 (o)
# 3 -> Final(o)
