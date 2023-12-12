# File:
build/task.obj

# Subroutines:
get_task
has_task

# Addresses:
x3400
x4450

# Purpose:
## get_task
Returns the address of a given task at the given location (R1) and stores the result in R1
## has_task
Simply returns 1 in R0 if there is a task, and 0 in R0 if there isn't a task.