ADD x1 x2 x30
jalr x1 x2 60
lw x1 60(x2)
sw x1 60(x3)
slli x1 x2 3
bge x1 x2 6
auipc x1 3