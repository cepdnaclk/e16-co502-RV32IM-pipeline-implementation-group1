addi x1 x0 10
addi x2 x0 5
add x3 x1 x2
sub x4 x1 x2
sw x3 0(x0)
sw x4 4(x0)
lw x5 0(x0)
lw x6 4(x0)