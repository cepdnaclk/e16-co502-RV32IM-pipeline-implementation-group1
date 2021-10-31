---
layout: default
title: Pipeline Register
parent: Hardware Units
nav_order: 9
---

# Pipeline Register

---

In‌ ‌CPU‌ ‌pipelines,‌ ‌pipeline‌ ‌registers‌ ‌are‌ ‌used‌ ‌to‌ ‌store‌ ‌the‌ ‌information‌ ‌and‌ ‌control‌ ‌signals‌ ‌related‌ ‌to‌‌ the‌ ‌instruction.‌ ‌In‌ ‌this‌ ‌CPU‌ ‌design‌ ‌there‌ ‌are‌ ‌5‌ ‌stages,‌ ‌

- Instruction‌ ‌Fetch‌ ‌stage‌ ‌
- Instruction‌ ‌Decode‌ ‌stage‌ ‌
- Execution‌ ‌stage‌ ‌
- Memory‌ ‌Access‌ ‌stage‌ ‌
- Writeback‌ ‌stage‌

In‌ ‌between‌ ‌each‌ ‌stage‌ ‌there‌ ‌is‌ ‌a‌ ‌pipeline‌ ‌register.‌‌ ‌

- IF/ID‌ ‌pipeline‌ ‌register‌ ‌
- ID/EX‌ ‌pipeline‌ ‌register‌ ‌
- EX/MEM‌ ‌pipeline‌ ‌register‌ ‌
- MEM/WB‌ ‌pipeline‌ ‌register‌

Data‌ ‌and‌ ‌control‌ ‌signals‌ ‌are‌ ‌written‌ ‌to‌ ‌the‌ ‌pipeline‌ ‌registers‌ ‌at‌ ‌the‌ ‌positive‌ ‌edge‌ ‌of‌ ‌the‌ ‌clock‌ ‌cycle‌‌ and‌ ‌when‌ ‌the‌ ‌reset‌ ‌signal‌ ‌is‌ ‌set,‌ ‌the‌ ‌pipeline‌ ‌registers‌ ‌will‌ ‌get‌ ‌reset.

![IF/ID](../images/hardware_units/pipeline_reg/if_id.png)
![ID/EX](../images/hardware_units/pipeline_reg/id_ex.png)
![EX/MEM](../images/hardware_units/pipeline_reg/ex_mem.png)
![MEM/WB](../images/hardware_units/pipeline_reg/mem_wb.png)
