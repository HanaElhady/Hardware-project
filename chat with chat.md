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

![image](https://github.com/user-attachments/assets/34d0241f-ef88-456a-b192-52d8e1802819)

The MIPS instructions we focus on typically read two registers, perform an ALU operation, and then write the result back to a register. These arithmetic and logical operations are known as **R-type instructions** (as described in \[PaHe98], p. 154), and include instructions such as `add`, `sub`, `slt`, `and`, and `or`.

The processor contains **32 general-purpose registers**, organized in a component called the **Register File**.

* To **read data**, the Register File requires **two 5-bit input lines**, each specifying a register number, and provides **two 32-bit output lines** carrying the corresponding register values.
* To **write data**, it needs **one 5-bit input** to indicate the destination register and **one 32-bit input** to supply the data to be written.
  
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

### 📥 Why do we need separate **data inputs**?

Once you choose a register, you still need to:

* Give it **data to store** (when writing),
* Or **get its data out** (when reading).

So there's a difference between:

* 🔢 The **5-bit input**: says *"which register?"*
* 📦 The **32-bit input/output**: is the *actual data* going in or out of the register

---

### 🧮 Example: Writing a value into a register

Imagine we want to put the number `42` into register `$t0` (which is register 8).

In hardware, that would mean:

* 5-bit input: `01000` (this selects register 8)
* 32-bit input: `0000...101010` (this is the binary of 42)
* The control signal `RegWrite` would be `1` to allow writing

So now register 8 stores the value `42`.

---

### ✅ Summary

| Purpose                                 | Bits    | Why it's needed                           |
| --------------------------------------- | ------- | ----------------------------------------- |
| **Choose which register** to read/write | 5 bits  | 32 registers → needs 5 bits to select one |
| **Move data in/out** of the register    | 32 bits | Each register stores a 32-bit value       |
| **Control signals** (like RegWrite)     | 1 bit   | Enables the write operation               |

---

  ![image](https://github.com/user-attachments/assets/9d1c5bab-ae3f-41cd-a3d7-34826a4580ff)


```
add $t0, $t1, $t2
```

Which means:

```
$t0 = $t1 + $t2
```

Now step-by-step through the diagram:

---

### 📥 **Instruction**

* The instruction comes into the datapath.

* For this `add` instruction, the 32-bit format is:

  ```
  op   rs   rt   rd   shamt  funct
  000000 01001 01010 01000 00000 100000
   add  $t1   $t2   $t0   -      add
  ```

* So:

  * `rs` (source 1) = `$t1` = register 9
  * `rt` (source 2) = `$t2` = register 10
  * `rd` (destination) = `$t0` = register 8

---

### 📌 **Read register 1**

* Input: `rs` = 9 → selects register 9
* Output: **Read data 1** = value of `$t1`, say **7**

---

### 📌 **Read register 2**

* Input: `rt` = 10 → selects register 10
* Output: **Read data 2** = value of `$t2`, say **5**

---

### 🧠 **These two values go into the ALU**

* ALU operation: `add`
* Inputs: 7 and 5
* Output: 12

---

### 📌 **Write register**

* Input: `rd` = 8 → tells the register file to write to register 8 (`$t0`)

---

### 📌 **Write data**

* Input: the result from the ALU = **12**
* This is what gets written into register 8

---

### ✅ **RegWrite**

* A control signal that enables writing to the register file.
* Set to `1` (enabled) for this instruction

---

### 🧾 Summary Table for `add $t0, $t1, $t2`

| Signal          | Value               | Purpose              |
| --------------- | ------------------- | -------------------- |
| Instruction     | `add $t0, $t1, $t2` | Encoded in 32 bits   |
| Read register 1 | 9                   | Selects `$t1`        |
| Read register 2 | 10                  | Selects `$t2`        |
| Write register  | 8                   | Targets `$t0`        |
| Read data 1     | 7                   | Value in `$t1`       |
| Read data 2     | 5                   | Value in `$t2`       |
| ALU operation   | `add`               | Adds the inputs      |
| ALU result      | 12                  | Output of `7 + 5`    |
| Write data      | 12                  | What goes into `$t0` |
| RegWrite        | 1                   | Enables the write    |

---

### 🧠 Why do we **choose** a register?

Think of **registers like lockers in a gym**. Each locker has a number (0 to 31). If you want to:

* Get something from a locker,
* Or put something into a locker,

You have to **specify the locker number**. The CPU works the same way—it has to **select** which register to use.

So:

* To **read** from a register, you must tell the CPU **which one** (e.g., register 5? register 12?).
* To **write** to a register, again you must **choose which** register to write into.

That’s why we need **5-bit addresses** (to select one of 32 registers).

---
# Load word (lw) and store word (sw) instructions

### Additional Elements for `lw` and `sw` Instructions

To support `lw` (load word) and `sw` (store word) instructions in a MIPS datapath, **two additional components** are required:

![image](https://github.com/user-attachments/assets/70206eb4-41b2-4407-965e-35808875aedf)

1. **Data Memory** – for reading from and writing to memory.
2. **Sign Extension Unit** – for converting 16-bit immediate offsets to 32-bit values.

#### Memory Address Calculation

Both `lw` and `sw` instructions compute a **memory address** by **adding**:

* A value from a **base register**, and
* A **16-bit signed offset** provided in the instruction.

Since the ALU operates on **32-bit values**, the 16-bit offset must first be **sign-extended** to 32 bits. This is done by replicating the **sign bit** (the most significant bit of the 16-bit offset) to fill the upper 16 bits. This preserves the offset’s sign in 32-bit form.

![image](https://github.com/user-attachments/assets/a8f08fd2-374e-4272-9d5f-b969e3bff858)


---
### 🧠 What are `lw` and `sw` Instructions?

These are **I-type (Immediate-type)** MIPS instructions used for **memory access**:

| Instruction | Meaning        | Purpose                                    |
| ----------- | -------------- | ------------------------------------------ |
| `lw`        | **Load Word**  | Loads 4 bytes from memory into a register  |
| `sw`        | **Store Word** | Stores 4 bytes from a register into memory |

---

### 🧾 Syntax:

* **`lw $t1, 8($t2)`**
  → Load the word from memory address `$t2 + 8` into `$t1`

* **`sw $t1, 8($t2)`**
  → Store the word in `$t1` into memory address `$t2 + 8`

Here:

* `$t2` = base address
* `8` = offset
* Offset is a **signed 16-bit immediate** (can be negative)

---

### 🔁 Data Path Flow of `lw $t1, 8($t2)`

1. **Instruction fetched** from memory (e.g., `lw $t1, 8($t2)`).

2. The instruction fields are:

   * Base register = `$t2`
   * Offset = `8`
   * Destination register = `$t1`

3. **Register file** reads:

   * Value of `$t2` (base address)

4. **Sign-extension unit**:

   * Converts the 16-bit offset `8` to a 32-bit signed value

5. **ALU**:

   * Adds `$t2` value + extended offset to calculate the memory address

6. **Data memory**:

   * Reads the 32-bit word stored at the calculated memory address

7. **Register file**:

   * Writes the data to register `$t1`

---

### 🔁 Data Path Flow of `sw $t1, 8($t2)`

Same steps as `lw`, except:

* The register file reads both `$t1` (data to store) and `$t2` (base address)
* ALU calculates address as `$t2 + 8`
* **Data Memory** writes the value in `$t1` to the computed address

---

### 🔧 Example:

Assume:

* `$t2 = 1000` (base address)
* `$t1 = 42` (value to store)
* `sw $t1, 8($t2)`

Then:

* Effective address = `1000 + 8 = 1008`
* Memory location 1008 will store the value `42`

---

### 📦 1. Why We Need **Memory** If We Have **Registers**

Think of it like this:

| Registers (like \$t0, \$t1...) | Memory (RAM)                                  |
| ------------------------------ | --------------------------------------------- |
| Very small (only 32 registers) | Very large (can be thousands of words)        |
| Super fast to access           | Slower than registers                         |
| Used for quick calculations    | Used to store large data, arrays, files, etc. |
| Inside the CPU                 | Outside CPU, but connected to it              |

#### ✅ Analogy:

Imagine registers as your **desk space** — fast and right in front of you. But it’s small.

Memory is like your **bookshelf** — holds lots of info, but you need to go over and get stuff from it.

When you're writing programs, 32 registers are NOT enough to store everything, so you store most data in memory (RAM), and move it into registers only when needed (using `lw`) or back into memory (using `sw`).

---

### 🔁 2. Why We Need a **Sign Extension Unit**

The **Sign Extension Unit** is *not memory*. It’s a small logic circuit that takes a **16-bit signed number** and turns it into a **32-bit signed number**, preserving its value.

#### Example:

You have this instruction:

```
lw $t1, -4($t2)
```

Here `-4` is a 16-bit number: `1111 1111 1111 1100`

The ALU needs a 32-bit number. So the sign extender takes this 16-bit value and makes it:

```
1111 1111 1111 1111 1111 1111 1111 1100   ← still -4 in 32-bit
```

It **doesn’t store** anything — it just stretches the bits to match ALU size.

---

### ✅ Summary

| Component             | What It Does                           | Is It Memory? |
| --------------------- | -------------------------------------- | ------------- |
| **Registers**         | Fast small storage inside CPU          | ✅ Yes (small) |
| **Main Memory (RAM)** | Big storage for program/data           | ✅ Yes         |
| **Sign Extender**     | Just extends a 16-bit number to 32-bit | ❌ No (logic)  |

---

![image](https://github.com/user-attachments/assets/49f40396-f46b-4009-a841-494e128de5dc)

---

### 👇 In the diagram:

* There are **two control signals** coming into the **Data Memory** block:

  * `MemWrite`
  * `MemRead`

And another control signal:

* `RegWrite` to the **Registers** block.

---

### ✅ What happens depending on the instruction?

#### 📌 If the instruction is **`lw` (load word)**:

* The processor should:

  * Compute the address (via ALU),
  * **Read** from memory at that address,
  * **Write** that data into a register.

So the control signals are:

* `MemRead = 1`
* `MemWrite = 0`
* `RegWrite = 1`

#### 📌 If the instruction is **`sw` (store word)**:

* The processor should:

  * Compute the address (via ALU),
  * **Write** register data into memory at that address,
  * **Not write** anything back to a register.

So the control signals are:

* `MemRead = 0`
* `MemWrite = 1`
* `RegWrite = 0`

---

### 🧠 Therefore, yes — **there is a condition (based on the instruction opcode)**, and the control unit ensures that:

* When `sw` is active → `MemWrite = 1`, `MemRead = 0`, `RegWrite = 0`
* When `lw` is active → `MemWrite = 0`, `MemRead = 1`, `RegWrite = 1`

It’s either one **or** the other — just as you said: **if one is 1, the other is 0**, because they represent different actions on memory.

---

![image](https://github.com/user-attachments/assets/6b7ed501-dfd1-4293-bd07-f5923ab9ee25)

Sure! Let's break this down clearly and explain both the **branch on equal (`beq`)** instruction and the flow shown in the **Figure 2.8 datapath**.

---

### 🔄 **Summary: beq Instruction Flow**

The `beq` instruction is used for conditional branching. It checks **if two registers are equal**, and **if they are**, the program branches (jumps) to a target address. If not, it continues to the next instruction.

**Operands in `beq`**:

* Two registers to compare (e.g., `beq $t1, $t2, label`)
* A **16-bit offset** to calculate the **branch target address** (relative to current instruction)

---

### 🧠 **What Happens Internally (as shown in the diagram)**

This datapath does two main things:

1. **Compares the contents of two registers**
2. **Computes the branch target address** if they are equal

---

### ✅ **Step-by-Step Flow in the Datapath Diagram**:

1. **Instruction Input**:

   * The `beq` instruction is fetched and enters the datapath.
   * The instruction provides:

     * 2 registers to compare
     * A 16-bit offset value

2. **Register File Access**:

   * Two **read registers** are selected based on the instruction.
   * Their **values (Read data 1 & Read data 2)** are fetched from the register file.

3. **ALU Comparison**:

   * The ALU subtracts `Read data 1 - Read data 2`.
   * If the result is **zero**, it means the values are **equal** → ALU outputs **Zero = 1**.
   * This **Zero flag** is sent to the **branch control logic**.

4. **Sign Extend & Shift**:

   * The **16-bit offset** is sign-extended to 32 bits.
   * It’s then **shifted left by 2 bits** to make it a word-aligned address (because instructions are word-aligned).

5. **Branch Target Address Calculation**:

   * The **PC + 4** (address of the next instruction) is added to the **shifted offset**.
   * The result is the **branch target address**.

6. **Decision to Branch**:

   * If the **Zero flag is 1** (i.e., registers are equal), the branch control logic selects the **branch target address** as the next PC.

---

### 🪂 **Jump vs. Branch (from 2.1.5)**:

* **Branch (`beq`)**:

  * **Conditional**
  * Uses **offset + PC + 4**
* **Jump (`j`)**:

  * **Unconditional**
  * Builds the jump address differently:

    * Takes upper 4 bits of `PC+4`
    * Adds 26-bit address from instruction
    * Appends 2 zeros at the end (since instructions are word-aligned)

---

### 🖼️ Diagram Focus Highlights:

* **Registers block**: Reads operands and outputs their values
* **ALU**: Compares the register values
* **Sign Extend & Shift Left 2**: Prepares the offset
* **Add Unit**: Computes final target address
* **MUX**: Selects between continuing sequentially or branching

---

### 🔁 What is a Jump?

A **jump (`j`)** is like saying:

> "Forget the normal order. I want the CPU to go directly to a specific instruction somewhere else in memory."

* It's **unconditional** – it always happens.
* Example: `j 1000` means → "Go to instruction at address 1000".

So the **CPU sets the Program Counter (PC)** to this new address instead of just going to the next instruction.

---

### 🤔 What is Branch on Equal (`beq`)?

Branching is **like a decision**: "If condition is true, jump somewhere. Otherwise, continue normally."

`beq $t1, $t2, label` means:

> “If `$t1 == $t2`, go to the instruction labeled `label`. Otherwise, just go to the next instruction.”

This is how loops and `if` statements work in assembly language.

---

### 💡 Why Compare Registers? (Why equality matters)

To make **decisions**, the CPU needs to **compare data**.

Let’s say you’re writing code like:

```c
if (x == y) {
    // do something
}
```

In assembly, this turns into:

```asm
beq $t1, $t2, LABEL
```

So comparing register values lets the CPU **decide** what to do next. If they are equal → branch. If not → move on.

---

### 🧮 What’s with Shifting and Word-Aligned Addresses?

In MIPS (the architecture here):

* **Each instruction is 4 bytes (32 bits)**.
* Memory addresses increase in steps of 4: `0, 4, 8, 12, ...`
* This is called **word-aligned**.

When an instruction says “jump 2 instructions ahead”, we multiply that number by 4 to get the byte offset → hence the **shift left by 2** (i.e., multiply by 4).

---

### 🧱 Why do we Shift the Offset Left 2 Bits?

Because:

* The **instruction gives an offset in words**, not bytes.
* But memory addresses are in bytes.
* So, we **shift left 2 bits** (multiply by 4) to convert the word offset into a byte offset.

#### Example:

If offset = `3` (as in `beq $t1, $t2, 3`)

* It's really 3 \* 4 = 12 bytes forward
* So the branch target = `PC + 4 + 12`

---
### 💡 How Do We Convert?

We use a **shift left by 2 bits**, which multiplies the number by 4.

> So yes, **because we need 3 → 12**, we shift it left by 2.

#### Example:

* Offset in instruction: `0000 0000 0000 0011` (which is 3)
* After shift left 2 bits: `0000 0000 0000 1100` → now it's 12 (in binary)

### 🔗 Putting It All Together

| Instruction       | Meaning                                                                   |
| ----------------- | ------------------------------------------------------------------------- |
| `beq $s0, $s1, 4` | If \$s0 == \$s1, go 4 instructions ahead (i.e., `PC + 4 + (4 × 4)` bytes) |
| `j 1024`          | Go directly to address 1024 (no condition)                                |


---

### ✅ **Clarifying `beq` (Branch if Equal):**

> "So `beq` first checks, and if the result is 1, we jump. If not, we continue normally."

**Exactly right.** Here’s how it works:

1. `beq $s0, $s1, label` means:

   * Compare contents of `$s0` and `$s1`
2. If they are **equal**, the ALU sets a flag called **Zero = 1**
3. That Zero flag tells the control unit: “Yes, branch!”
4. So the CPU **jumps** to the instruction at `label`
5. If they’re **not equal**, Zero = 0 → the CPU just goes to the **next instruction**

---

### ❓ Is the Jump Like a “Priority” Instruction?

That’s a good question. The short answer is:

> **No, it’s not higher priority. It’s a control flow change.**

* The **jump or branch isn't more important**, it just tells the CPU:
  “Next, don’t go to the next line. Go to this specific address instead.”
* It’s like giving directions:

  * Normally: go to the next house
  * With `beq` (or `j`): if the condition is met, take a shortcut or detour

---

### 🚦Analogy Time: Traffic Light

* You're driving (executing instructions)
* **Green light = go to the next instruction**
* **Beq is like a detour sign**:

  * “If the road is blocked (condition met), turn left”
  * Otherwise, keep going straight

---

### 🧭 Summary of Concepts:

| Concept       | Meaning                                                 |
| ------------- | ------------------------------------------------------- |
| `beq`         | Branches *only if* two registers are equal              |
| `Zero = 1`    | ALU found the values are equal (subtraction result = 0) |
| Jump (`j`)    | Always goes to a new address, no condition              |
| Shift left 2  | Converts word offset to byte offset (multiplies by 4)   |
| PC + 4        | The address of the next instruction normally            |
| Branch target | PC + 4 + shifted offset                                 |

---

### 💬 Think of Jump Like This:

* You're reading a recipe.
* Normally, you follow step by step.
* But it says: “**If you already boiled the pasta, skip to Step 7**.”
* That “skip to Step 7” is like a **jump**.

---




