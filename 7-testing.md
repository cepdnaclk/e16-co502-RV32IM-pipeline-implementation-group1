---
layout: default
title: Testing
nav_order: 7
---

# Testing

---

## Testing‌ ‌individual‌ ‌modules‌ ‌

Testbenches‌ ‌to‌ ‌test‌ ‌individual‌ ‌hardware‌ ‌units‌ ‌were‌ ‌implemented‌ ‌and‌ ‌all‌ ‌the‌ ‌tests‌ ‌were‌ ‌automated.‌‌ Scripts‌ ‌to‌ ‌test‌ ‌the‌ ‌individual‌ ‌hardware‌ ‌units‌ ‌are‌ ‌in‌ ‌the‌ ‌`/cpu/scripts‌` ‌directory.‌ ‌
‌
NOTE‌ ‌:‌ ‌Make‌ ‌sure‌ ‌to‌ ‌set‌ ‌execute‌ ‌permission‌ ‌for‌ ‌test‌ ‌scripts‌ ‌if‌ ‌needed.

## Testing‌ ‌overall‌ ‌CPU‌ ‌

‌
There‌ ‌are‌ ‌several‌ ‌programs‌ ‌defined‌ ‌in‌ ‌the‌ `‌/cpu`‌ ‌directory‌ ‌(eg:‌ ‌program.s,‌ ‌program1.s‌ ‌etc.)‌. To‌ ‌test‌ ‌an‌‌ assembly‌ ‌program,‌ ‌add‌ ‌the‌ ‌assembly‌ ‌program‌ ‌to‌ ‌the‌ ‌`/cpu‌` ‌directory‌ ‌and‌ ‌run‌ ‌`test-program.sh‌` ‌script‌‌ with‌ ‌the‌ ‌program‌ ‌file‌ ‌as‌ ‌an‌ ‌argument.‌ ‌
Eg:‌ `./test-program.sh‌ ‌program.s‌`
‌
Two‌ ‌sample‌ ‌test‌ ‌programs‌ ‌included‌ ‌

- `program.s`‌ ‌-‌ ‌simple‌ ‌program‌ ‌with‌ ‌alu‌ ‌operations,‌ ‌load,‌ ‌storing‌ ‌with‌ ‌data‌ ‌hazards‌ ‌
- `program2.s`‌ ‌-‌ ‌simple‌ ‌program‌ ‌that‌ ‌decrements‌ ‌value‌ ‌of‌ ‌R1‌ ‌from‌ ‌5‌ ‌to‌ ‌0‌ ‌with‌ ‌data‌ ‌and‌ ‌control‌‌ hazards‌ ‌

**IMPORTANT!‌**
iverilog‌ ‌version‌ ‌11‌ ‌was‌ ‌used‌ ‌to‌ ‌implement‌ ‌the‌ ‌pipeline‌ ‌CPU.‌ ‌Using‌ ‌an‌ ‌iverilog‌ ‌version‌ ‌lower‌‌ than‌ ‌11‌ ‌will‌ ‌cause‌ ‌unexpected‌ ‌results.‌ To‌ ‌see‌ ‌the‌ ‌correct‌ ‌functioning‌ ‌of‌ ‌the‌ ‌CPU‌ ‌you‌ ‌have‌ ‌to‌‌ have‌ ‌iverilog‌ ‌version‌ ‌11‌ ‌installed.‌‌ ‌
To‌ ‌check‌ ‌the‌ ‌iverilog‌ ‌version‌ ‌use‌ ‌the‌ ‌`iverilog‌ ‌-v` ‌command.‌ ‌
If‌ ‌you‌ ‌don’t‌ ‌have‌ ‌verilog‌ ‌v11‌ ‌installed,‌ ‌you‌ ‌can‌ ‌download‌ ‌it‌ ‌from‌ ‌[here](http://archive.ubuntu.com/ubuntu/pool/universe/i/iverilog/iverilog_11.0-1_amd64.deb).‌ ‌(for‌ ‌linux‌ ‌users‌ ‌only)‌
