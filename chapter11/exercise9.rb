# Exercise 9

# record size = 1024, pointer size = 8
# 2K records plus 2K+1 pointers
# B-tree bucket size = 1024 * 2K + 8 * (2K + 1) = 2064K + 8

# block size is 2 * 1024 = 2048
# there are 4 blocks per bucket = 4 * 2048 = 8192 (space to use per node)

# 2064K + 8 <= 8192
# K <= 8184 / 2064
# K <= 3.965

# *** For B-tree max value of K is 3(3.965) ***

# key size = 100
# 2K keys plus 2K+1 pointers
# B+tree bucket size = 100*2K + 8 * (2K + 1) = 216K + 8

# 216K + 8 <= 8192
# K <= 8184/216
# K <= 37.889

# *** For B+tree max value of K is 37(37.889) ***

# Tree of order K has max height Math(num_items,K+1)

# Math.log(10000,3+1) = 6.6

# *** For B-tree max height is 7 ***

# Math.log(10000,37+1) = 2.5

# *** For B+tree max height is 3 ***
