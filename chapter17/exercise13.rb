# Exercise 13
# If detection algorithm returns false, result of reporting algorithm
# is also false. Otherwise, find object with greatest value and assign
# it to subset A. Loop through all remaining objects and try adding
# their values to max object. Also remove objects from original set.
# At every step check if partitioning is possible. If it is, consider
# next object. Else, undo previous step, subtract object's value from
# max object and remove element from original set. At the end, only 1
# item with value 0 will remain. Objects whose values were added belong
# to set A and those whose values were subtracted should be in set B.
