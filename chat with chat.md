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
كلمة **"تعليمة"** في سياق المعالج (Processor) معناها:

> 🔹 **أمر بسيط بيطلب من المعالج ينفذ عملية معينة.**

---

## ✅ مثال مبسط:

لما تكتبي برنامج بلغة C مثلاً:

```c
int a = b + c;
```

الكمبايلر بيحوّله لتعليمة (أو أكثر) بلغة الآلة، زي مثلاً:

```asm
add $t0, $t1, $t2
```

دي تعليمة بلغة MIPS، ومعناها:

> اجمع قيمة المسجل `$t1` مع `$t2`، وخزّن الناتج في `$t0`.

---

## 📋 أنواع التعليمات (Instructions):

1. **Arithmetic Instructions** – تعليمات حسابية:
   - `add`, `sub`, `mul`, `div` …
2. **Logical Instructions** – تعليمات منطقية:
   - `and`, `or`, `xor`, `not` …
3. **Memory Instructions** – تعليمات ذاكرة:
   - `lw` (load word), `sw` (store word)
4. **Branch/Jump Instructions** – تعليمات القفز:
   - `beq` (branch if equal), `j` (jump)

---

## 💡 المهم تعرفيه:

- كل تعليمة بيكون ليها **صيغة محددة (Format)** وعدد معين من البتات (عادةً 32-bit في MIPS).
- المعالج بيقرأ التعليمة من الذاكرة وينفذها خطوة بخطوة حسب التصميم.

---

## 🚀 أولاً: Single-Cycle Processor

### ✅ الفكرة:
- كل تعليمة (Instruction) بتتنفذ **في دورة ساعة واحدة (1 Clock Cycle)**.
- الدورة دي لازم تكون **طويلة بما فيه الكفاية** عشان تخلّص أصعب تعليمة.

### 📏 مثال:
لو عندك تعليمة `lw` (load word) بتحتاج:
- جلب تعليمة
- فك الشفرة
- حساب عنوان
- قراءة من الذاكرة
- كتابة في register

كل ده لازم يتم في **نفس دورة الساعة**. بالتالي، باقي التعليمات (زي `add`) اللي أسهل هتضطر تستنى نفس الوقت، وده بيبقى **هدر زمني**.

### ✴️ المميزات:
- بسيط في التصميم.
- كل تعليمة تاخد نفس الوقت.

### ❌ العيوب:
- الدورة لازم تكون طويلة جدًا لاستيعاب أصعب تعليمة → ده بيبطّأ باقي التعليمات.
- غير فعال من حيث السرعة والطاقة.

---

## ⚙️ ثانياً: Multi-Cycle Processor

### ✅ الفكرة:
- كل تعليمة بتتقسم إلى **مراحل (مثل IF, ID, EX, MEM, WB)**.
- كل مرحلة تاخد **دورة واحدة فقط**.
- فكل تعليمة ممكن تاخد **3 إلى 5 دورات** حسب تعقيدها، مش كلها متساوية.

### 📏 مثال:
- `add` → تاخد 4 دورات (IF → ID → EX → WB)
- `lw` → تاخد 5 دورات (IF → ID → EX → MEM → WB)

يعني المعالج بيكمل التعليمة على مراحل، وده يخلي كل دورة قصيرة ومحددة.

### ✴️ المميزات:
- أكتر كفاءة (مفيش هدر).
- كل مرحلة بسيطة وسريعة.
- ممكن إعادة استخدام وحدات زي الـ ALU في أكتر من مرحلة.

### ❌ العيوب:
- التصميم أعقد.
- محتاج وحدة تحكم متقدمة (Finite State Machine) لتوليد إشارات التحكم المناسبة لكل Cycle.

---

## 🆚 مقارنة سريعة:

| المقارنة            | Single-Cycle               | Multi-Cycle                  |
|---------------------|----------------------------|------------------------------|
| عدد الدورات لكل تعليمة | 1                          | 3 إلى 5 (حسب التعليمة)      |
| طول دورة الساعة       | طويل جدًا                  | قصير                         |
| الأداء               | أبطأ نسبيًا (بسبب الهدر)    | أسرع (أكفأ)                  |
| التعقيد في التصميم    | بسيط                        | أعقد                        |
| استخدام الوحدات      | غير مشترك                   | مشترك (توفير في الهاردوير)   |

---

## 💡 الخلاصة:
- **Single-Cycle** مناسب للتصميمات التعليمية أو البسيطة.
- **Multi-Cycle** أكثر واقعية وفعالية، ويُستخدم في المعالجات الفعلية غالبًا.

---
# **مرحلة التنفيذ (Execution Cycle)**
![image](https://github.com/user-attachments/assets/6dd2a5bf-c42a-4107-b2db-5a51a60a1608)


1. **Memory Reference Instructions (SW, LW)**  
   - دي التعليمات اللي بتتعامل مع الذاكرة.  
   - في مرحلة التنفيذ، بيتم استخدام **ALU** لحساب عنوان الذاكرة.  
   - **MUX** و **Sign Extension** بيشتغلوا هنا عشان يحددوا القيمة اللي تدخل ALU.

2. **R-Type Instructions (زي add, sub, and...)**  
   - هنا الـ **ALU** بتكون مسؤولة عن تنفيذ العملية (جمع، طرح...).  
   - **MUX** يختار البيانات اللي هتدخل للـ ALU.  
   - مش محتاجين Sign Extension لأن كله من الـ registers.

3. **Branch Instructions (BEQ, BNE)**  
   - الـ **ALU** بتستخدم لمقارنة القيم (هل قيمتين متساويتين أو لأ).  
   - الناتج من الـ ALU بيحدد هل هنفرّع ولا لأ.  
   - **Sign Extension** بتجهز الإزاحة (offset) اللي ممكن نضيفه للـ PC لو فيه فرع.

4. **Jump Instructions (J, JAL)**  
   - مش بيعتمدوا على ALU أو Shifter، لكن ممكن نحتاج بعض الـ MUXات عشان نغير قيمة الـ PC.  
---

---
## Resource : 

#### Book : Processor Implementation in VHDL According to Computer Organisation & Design by David A. Patterson and John L. Hennessy


To begin understanding how MIPS instructions are executed, we first identify the essential components and how they are connected.

![image](https://github.com/user-attachments/assets/57c63c82-12be-4b9b-9ebd-cf743e0b2022)

**Instruction Memory**  which stores the program instructions and provides them based on a given address.
This address is held in the **Program Counter (PC)**, which keeps track of the current instruction.
To move to the next instruction, we use an **Adder** that increments the PC by 4 (since each instruction is 4 bytes long), updating it to the address of the next instruction.

After fetching one instruction from the instruction memory, the program counter has to be incremented so that it points to the address of the next instruction 4 bytes later.

![image](https://github.com/user-attachments/assets/0cc9df4d-2e7f-4663-aa9c-04806f48221c)


---

![image](https://github.com/user-attachments/assets/34d0241f-ef88-456a-b192-52d8e1802819)


### 🌟 What is a **Register**?

A **register** is a small, fast memory location inside the processor.
Think of it like a **named box** that temporarily holds data (usually numbers) while the CPU is working.

In MIPS, we have **32 registers**, named `$0, $1, ..., $31`. Each register holds **32 bits** (i.e., 4 bytes) of data.

---

### 🧮 What is `slt`?

`slt` stands for **Set on Less Than**.
It's an instruction used to compare two numbers.

#### Example:

```assembly
slt $t0, $t1, $t2
```

This means:

> If the value in `$t1` is **less than** the value in `$t2`, then set `$t0 = 1`.
> Otherwise, set `$t0 = 0`.

It's useful for making decisions (like in `if` statements).

---

### 🧠 Why **32 registers**?

MIPS architecture is **designed with 32 general-purpose registers** to:

* Make the CPU fast (data in registers is accessed faster than in memory),
* Be efficient (not too few, not too many),
* Follow standard ISA conventions (MIPS is designed this way).

---

### 🔌 Why **two 5-bit inputs**?

To select a register, we need to **specify its number** (0 to 31).
And to represent numbers from 0 to 31 in binary, we need **5 bits** (because 2⁵ = 32).

So:

* We need **two 5-bit inputs** to read from **two registers** (e.g., source operands for `add`, `slt`, etc.)

---

### 🔄 Why **two 32-bit outputs**?

Each register stores a 32-bit value (since MIPS is a 32-bit architecture).
So when we read data from two registers, we get **two 32-bit outputs**.

---

### ✅ Example in practice:

Imagine this instruction:

```assembly
add $t0, $t1, $t2
```

This means:

> \$t0 = \$t1 + \$t2

The processor:

1. **Reads** the values in `$t1` and `$t2` → needs two 5-bit inputs (to choose the registers), and two 32-bit outputs (the data in the registers).
2. **Sends them to the ALU**, which adds the values.
3. **Writes** the result into `$t0` → needs one 5-bit input (to choose the destination register) and one 32-bit input (the result).

---


