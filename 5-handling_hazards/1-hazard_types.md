---
layout: default
title: Types of Hazards
parent: Hazard Detection and Handling Hazards
nav_order: 1
---

# Types of Hazards

---

In‌ ‌a‌ ‌pipeline‌ ‌processor,‌ ‌there‌ ‌are‌ ‌different‌ ‌instructions‌ ‌in‌ ‌different‌ ‌stages.‌ ‌Due‌ ‌to‌ ‌the‌‌
dependencies‌ ‌between‌ ‌the‌ ‌instructions‌ ‌there‌ ‌can‌ ‌be‌ ‌hazards.‌ ‌These‌ ‌hazards‌ ‌can‌ ‌be‌ ‌categorized‌‌
into‌ ‌3‌ ‌main‌ ‌categories.‌ ‌
‌

- Data‌ ‌Hazards‌ ‌

Data‌ ‌hazards‌ ‌occur‌ ‌when‌ ‌there‌ ‌are‌ ‌data‌ ‌dependencies‌ ‌between‌ ‌instructions.‌‌ ‌
‌

- Control‌ ‌Hazards‌

Control‌ ‌hazards‌ ‌occur‌ ‌when‌ ‌there‌ ‌are‌ ‌control‌ ‌transfer‌ ‌instructions.‌ ‌Control‌ ‌transfer‌ ‌instructions‌‌
resolve‌ ‌a‌ ‌branch‌ ‌or‌ ‌a‌ ‌jump‌ ‌in‌ ‌the‌ ‌execution‌ ‌stage.‌ ‌When‌ ‌a‌ ‌branch‌ ‌or‌ ‌a‌ ‌jump‌ ‌is‌ ‌at‌ ‌the‌ ‌execution‌‌
stage,‌ ‌2‌ ‌instructions‌ ‌after‌ ‌the‌ ‌control‌ ‌transfer‌ ‌instruction‌ ‌are‌ ‌at‌ ‌the‌ ‌fetch‌ ‌stage‌ ‌and‌ ‌the‌ ‌decode‌‌
stage.‌‌If‌‌ the‌‌ branch‌‌ is‌‌ not‌‌ taken‌‌ then‌‌ there‌‌ will‌‌ be‌‌ no‌‌ hazard‌‌ occurring.‌‌But‌‌ if‌‌ the‌‌ branch‌‌ is taken‌‌ or‌‌ if‌‌ the‌ ‌control‌‌ transfer‌‌ instruction‌‌ is‌‌ a‌‌ jump‌‌ instruction‌‌, then‌‌ the‌‌ instructions‌‌ in‌‌ the‌‌ decode‌‌ and‌‌ fetch‌‌ stage‌ ‌have‌ ‌incorrect‌ ‌instructions‌ ‌and‌ ‌they‌ ‌have‌ ‌to‌ ‌be‌ ‌discarded.‌ ‌

- Structural‌ ‌hazards‌ ‌

Structural‌ ‌hazards‌ ‌occur‌ ‌when‌ ‌multiple‌ ‌instructions‌ ‌use‌ ‌the‌ ‌same‌ ‌resource.‌ ‌These‌ ‌types‌ ‌of‌ ‌hazards‌‌
are‌ ‌not‌ ‌in‌ ‌this‌ ‌processor‌ ‌because‌ ‌there‌ ‌are‌ ‌separate‌ ‌instruction‌ ‌and‌ ‌memory‌ ‌caches.‌
