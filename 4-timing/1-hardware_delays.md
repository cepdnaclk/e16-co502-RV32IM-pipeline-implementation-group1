---
layout: default
title: Simulation Delays of Hardware Units
parent: Timing and Simulation Delays
nav_order: 1
---

# Simulation Delays of Hardware Units

---

## Instruction‌ ‌Memory‌ ‌and‌ ‌Instruction‌ ‌Cache‌

Instruction‌ ‌memory‌ ‌is‌ ‌associated‌ ‌with‌ ‌the‌ ‌instruction‌ ‌cache.‌ ‌The‌ ‌memory‌ ‌access‌ ‌time‌ ‌will‌ ‌be‌‌
determined‌‌by‌‌hits‌‌and‌‌misses.‌‌To‌‌determine‌‌the‌‌hit‌‌or‌‌miss‌‌it‌‌takes‌‌2‌‌time‌‌units‌‌and‌‌if‌‌it's‌‌a‌‌hit,‌‌it‌‌
serves‌ ‌the‌ ‌data‌ ‌to‌ ‌the‌ ‌cpu‌ ‌after‌ ‌1‌ ‌time‌ ‌units.‌ ‌Altogether‌ ‌it‌ ‌takes‌ ‌3‌ ‌time‌ ‌units‌ ‌to‌ ‌access‌ ‌the‌‌
instruction.‌ ‌And‌ ‌if‌ ‌it‌ ‌is‌ ‌a‌ ‌miss,‌ ‌then‌ ‌the‌ ‌cache‌ ‌will‌ ‌have‌ ‌to‌ ‌fetch‌ ‌the‌ ‌data‌ ‌from‌ ‌the‌ ‌instruction‌‌
memory.‌ ‌To‌ ‌access‌ ‌the‌ ‌data‌ ‌from‌ ‌the‌ ‌instruction‌ ‌memory‌ ‌it‌ ‌takes‌ ‌40‌ ‌time‌ ‌units‌ ‌per‌ ‌byte.‌‌
Altogether‌ ‌it‌ ‌takes‌ ‌640‌ ‌time‌ ‌units‌ ‌to‌ ‌fetch‌ ‌an‌ ‌entire‌ ‌block‌ ‌(16‌ ‌bytes).

## Register‌ ‌File‌ ‌

In‌ ‌the‌ ‌register‌‌ file‌‌ reading‌‌ happens‌‌ asynchronously. Register‌‌ file‌‌ read‌‌ latency‌‌ will‌‌ be‌‌ 2‌‌ time‌‌ units.‌‌
The‌ ‌writing‌ ‌to‌ ‌the‌ ‌register‌ ‌file‌ ‌happens‌ ‌synchronously‌ ‌to‌ ‌the‌‌ positive‌‌ edge‌‌ of‌‌ the‌‌ clock.‌‌Register‌‌ file‌ ‌write‌ ‌delay‌ ‌will‌ ‌be‌ ‌1‌ ‌time‌ ‌unit.‌ ‌

## Data‌ ‌Memory‌ ‌and‌ ‌Data‌ ‌Cache‌ ‌

Data‌‌ memory‌‌ is‌‌ associated‌‌ with‌‌ the‌‌ data‌‌ cache.‌‌The‌‌ memory‌‌ access‌‌ time‌‌ will‌‌ be‌‌ determined‌‌ by‌‌ hits‌‌ and‌ ‌misses.‌ ‌To‌ ‌determine‌ ‌the‌‌ hit‌‌ or‌‌ miss‌‌ it‌‌ takes‌‌ 2‌‌ time‌‌ units‌‌ and‌‌ if‌‌ it's‌‌ a‌‌ hit, it‌‌ serves‌‌ the‌‌ data‌‌ to‌‌ the‌ ‌cpu‌ ‌after‌ ‌1‌ ‌time‌ ‌units.‌ ‌Altogether‌ ‌it‌ ‌takes‌ ‌3‌ ‌time‌ ‌units‌ ‌to‌ ‌access‌ ‌the‌ ‌data‌ ‌from‌ ‌the‌ ‌cache‌‌
memory.‌ ‌And‌ ‌if‌ ‌it‌ ‌is‌ ‌a‌ ‌miss,‌ ‌then‌ ‌the‌ ‌cache‌ ‌will‌ ‌have‌ ‌to‌‌ fetch‌‌ the‌‌ data‌‌ from‌‌ the‌‌ data‌‌ memory.‌‌To‌‌ access‌‌ the‌‌ data‌‌ from‌‌ the‌‌ data‌‌ memory‌‌ it‌‌ takes‌‌ 40‌‌ time‌‌ units‌‌ per‌‌ byte.‌‌Altogether‌‌ it‌‌ takes‌‌ 640‌‌ time‌‌ units‌ ‌to‌ ‌fetch‌ ‌an‌ ‌entire‌ ‌block‌ ‌(16‌ ‌bytes).‌ ‌

## Control‌ ‌Unit‌ ‌

Control‌ ‌unit‌ ‌generates‌ ‌the‌ ‌control‌ ‌signals‌ ‌of‌ ‌the‌ ‌instructions.‌ ‌Since ‌‌the‌‌ control‌‌ signal‌‌ generation‌‌ was‌ ‌implemented‌ ‌using‌ ‌basic‌ ‌combinational‌ ‌logic‌ ‌circuits‌ ‌the‌ ‌delay‌ ‌was‌ ‌assumed‌ ‌as‌ ‌1‌ ‌time‌ ‌unit.‌

## PC+4‌ ‌adder‌ ‌

The‌ ‌PC+4‌ ‌adder‌ ‌takes‌ ‌1‌ ‌time‌ ‌unit‌ ‌to‌ ‌calculate‌ ‌the‌ ‌PC+4‌ ‌value.‌ ‌

## PC‌ ‌Register‌ ‌

Writing‌ ‌to‌ ‌the‌ ‌PC‌ ‌register‌ ‌is‌ ‌done‌ ‌synchronously‌ ‌to‌ ‌the‌ ‌positive‌ ‌edge‌ ‌of‌ ‌the‌ ‌clock‌ ‌and‌ ‌it‌ ‌takes‌ ‌1‌‌ time‌ ‌unit.

## ALU‌ ‌

Depending‌ ‌on‌ ‌the‌ ‌complexity‌ ‌of‌ ‌the‌ ‌ALU‌ ‌operation‌ ‌following‌ ‌timing‌ ‌delays‌ ‌were‌ ‌used.

| Operation                                | DELAY (time units) |
| ---------------------------------------- | ------------------ |
| AND‌ ‌                                   | 1‌ ‌               |
| OR‌ ‌                                    | 1‌ ‌               |
| XOR‌ ‌                                   | 1‌ ‌               |
| ADD‌ ‌                                   | 2‌ ‌               |
| SUB‌ ‌                                   | 2‌ ‌               |
| SLT‌ ‌(Set‌ ‌less‌ ‌than)‌ ‌             | 2‌ ‌               |
| SLTU‌ ‌(Set‌ ‌less‌ ‌than‌ ‌unsigned)‌ ‌ | 2‌ ‌               |
| SLL‌ ‌(Shift‌ ‌left‌ ‌logical)‌ ‌        | 2‌ ‌               |
| SRL‌ ‌(Shift‌ ‌right‌ ‌logical)‌ ‌       | 2‌ ‌               |
| SRA‌ ‌(Shift‌ ‌right‌ ‌arithmetic)‌ ‌    | 2‌ ‌               |
| MUL‌ ‌                                   | 3‌ ‌               |
| MULH‌ ‌                                  | 3‌ ‌               |
| MULHSU‌ ‌                                | 3‌ ‌               |
| DIV‌ ‌                                   | 3‌ ‌               |
| DIVU‌ ‌                                  | 3‌ ‌               |
| REM‌ ‌                                   | 3‌ ‌               |
| REMU‌                                    | ‌3 ‌               |

## Pipeline‌ ‌Registers‌ ‌

Pipeline‌ ‌register‌ ‌writes‌ ‌happen‌ ‌synchronously‌ ‌to‌ ‌the‌ ‌clock‌ ‌at‌ ‌the‌ ‌positive‌ ‌edge‌ ‌of‌‌ the‌‌ clock.‌‌The‌‌ writing‌ ‌latency‌ ‌is‌ ‌taken‌ ‌as‌ ‌1‌ ‌time‌ ‌units.‌ ‌

## Branch‌ ‌Jump‌ ‌Detect‌ ‌Unit‌ ‌

This‌ ‌unit‌ ‌generates‌ ‌the‌ ‌PC_SELECT‌ ‌control‌ ‌signal‌ ‌depending‌ ‌on‌ ‌the‌ ‌BRANCH_JUMP‌ ‌signal.‌ ‌It‌‌
generates‌ ‌the‌ ‌PC_SELECT‌ ‌signal‌ ‌asynchronously‌ ‌with‌ ‌the‌ ‌2‌ ‌time‌ ‌units‌ ‌of‌ ‌delay.
