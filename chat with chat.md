## 🧠 أولاً: يعني إيه Multi-Cycle MIPS Processor؟

المعالج (Processor) اللي بينفذ تعليمات MIPS بيعدّي بعدة مراحل أساسية:

![image](https://github.com/user-attachments/assets/d7eecd76-cd12-444d-89e1-c8e01b78d043)

1. **Instruction Fetch (IF)** – جلب التعليمة من الذاكرة.
2. **Instruction Decode (ID)** – فك شفرة التعليمة وتجهيز البيانات.
3. **Execute (EX)** – تنفيذ العملية (زي جمع، طرح، مقارنة).
4. **Memory Access (MEM)** – قراءة أو كتابة في الذاكرة.
5. **Write Back (WB)** – كتابة الناتج في الريجستر.

في **Multi-Cycle Processor**، كل خطوة من دول بتتنفذ في **دورة ساعة (Clock Cycle) مختلفة**، مش في نفس الدورة. ده بيدي المعالج مرونة أكتر ويقلل الهدر مقارنة بـ Single-Cycle.

---

## 🧩 ثانياً: المعالج ده بيتكون من إيه؟ (أجزاء رئيسية)

- **Registers File** – مكان تخزين البيانات المؤقتة (الريجسترات).
- **ALU** – وحدة الحساب والمنطق.
- **Shifter** – وحدة الإزاحة (Shift left / right).
- **Sign Extension** – تحويل الأرقام الصغيرة (16-bit) لـ 32-bit مع الحفاظ على الإشارة.
- **MUX (Multiplexer)** – يختار ما بين مدخلات مختلفة حسب إشارة تحكم.
- **Memory** – ذاكرة التعليمات و البيانات.
- **Control Unit** – وحدة التحكم، تحدد إشارات التحكم في كل Cycle.
- **Program Counter (PC)** – يعد مؤشر للتعليمات.

---

## 🎯 ثالثاً: دورك (Person 2) – إيه الأجزاء اللي مسؤولة عنها؟

### 1. **ALU (Arithmetic Logic Unit)**

- مسؤولة عن تنفيذ العمليات الحسابية (جمع، طرح، and, or، مقارنة، ...).
- بيجيلها مدخلين وتنفذ العملية حسب `ALU Control`.

لازم تتعلمي:
- إزاي تبني ALU في VHDL أو أي لغة وصف عتادية.
- العمليات اللي لازم تدعميها حسب ISA بتاعة MIPS (مثلاً: add, sub, and, or, slt, ...).
- إزاي ترسميها باستخدام مخطط بوابات منطقية.

---

### 2. **Shifter**

- بتنقل البيانات يمين أو يسار (logical shift أو arithmetic shift).
- مهمة في بعض تعليمات MIPS زي `sll`، `srl`.

لازم تتعلمي:
- الفرق بين أنواع الشفتات.
- إزاي تعملي وحدة إزاحة parameterized في VHDL أو بوابات منطقية.

---

### 3. **Sign Extension**

- لما التعليمة يكون فيها Immediate (عدد 16-bit)، لازم نمده لـ 32-bit مع الحفاظ على الإشارة.
- مثال: `addi $t1, $t2, -3` → الـ -3 هنا 16 بت، نمدها لـ 32 بت.

لازم تتعلمي:
- إزاي تعملي Extend لـ 16-bit لغاية 32-bit مع الحفاظ على الإشارة.
- بتستخدم غالباً البت رقم 15 (أعلى بت في الرقم) عشان نعرف إذا كان موجب ولا سالب.

---

### 4. **MUX (Multiplexer)**

- بيستخدم لاختيار مدخل من مدخلين أو أكتر بناءً على إشارة تحكم.
- مثال: ALU تاخد المدخل التاني من register ولا immediate؟ هنا نحتاج MUX.

لازم تتعلمي:
- فكرة الـ MUX وأنواعها (2-to-1, 4-to-1).
- إزاي تكتبيها بلغة VHDL أو ترسميها بالبوابات.

---

## 📚 محتاج تتعلم إيه عشان تنفذي شغلك كويس؟

### لازم تكوني فاهمة:
1. **معمارية MIPS ISA** – وخصوصاً التعليمات اللي تستخدم ALU، Shifter، Immediate.
2. **Digital Design Basics** – بوابات منطقية، multiplexers، adders، shifters.
3. **VHDL أو Verilog** – لو هتعملي التصميم عملي على FPGA أو تحققيه.
4. **Data Path Design** – إزاي الأجزاء دي تتوصل ببعض داخل المعالج.

---

## 🎓 مصادر ممكن تبدأي منها:

- كتاب: *Computer Organization and Design* by Patterson & Hennessy.
- كورسات على YouTube:
  - Neso Academy – شرح الـ MIPS والـ datapath ممتاز.
  - Coursera: "Digital Systems: From Logic Gates to Processors".
- مواقع:
  - https://www.coursera.org/learn/computer-organization
  - https://www.geeksforgeeks.org/computer-organization-and-architecture/

---
