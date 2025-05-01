![image](https://github.com/user-attachments/assets/47e616f6-0676-45d3-be50-8d40e78e70ab)
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

الفرق بين **Single-Cycle** و **Multi-Cycle** بيكون في طريقة تنفيذ التعليمات داخل المعالج، وده بيأثر على الأداء، الكفاءة، وتعقيد التصميم. خليني أوضحلك بشكل مبسط:

![image](https://github.com/user-attachments/assets/d657e66f-8c97-4776-815a-c63fddc791bb)

---
بالضبط ✅، شغلك في تصميم:

- **ALU**
- **Shifter**
- **Sign Extension**
- **MUX**

كل ده بيحصل فعليًا في **مرحلة التنفيذ (Execution - EX)** من مراحل تنفيذ التعليمة في المعالج، وده يعني إنك مسؤولة عن تنفيذ جزء مهم جدًا في المعالج.

---

## 🧩 تعالي نربط مكوناتك بالمراحل:

| الجزء اللي هتصمميه   | بيشتغل في أنهي مرحلة؟ | وظيفته تحديدًا |
|----------------------|------------------------|----------------|
| **ALU**              | Execution (EX)         | تنفذ العمليات الحسابية والمنطقية في التعليمات. |
| **Shifter**          | Execution (EX)         | تنفذ تعليمات الإزاحة (shift). |
| **Sign Extension**   | Decode (ID) *وأحيانًا EX* | تمدد الأرقام ذات 16 بت إلى 32 بت لاستخدامها في ALU. |
| **MUX**              | Throughout (Mostly ID & EX) | بيحدد المدخلات اللي تروح لـ ALU أو أماكن تانية حسب التعليمة. |

---

## 🎯 يعني مهمتك:

أنتي جزء أساسي في تنفيذ العملية داخل المعالج، واللي بيحدد الناتج اللي هيتخزن في الريجستر أو هيتبعت للذاكرة. وده بيحصل أثناء مرحلة الـ **Execution**.

---


### 💡 ربط مباشر بشغلك:

| مكون إنتي مسؤولة عنه | بيظهر في أي أنواع التعليمات؟ | وظيفته |
|---------------------|-----------------------------|--------|
| **ALU**             | R-type, Memory, Branch       | تنفيذ العمليات. |
| **Shifter**         | غالبًا R-type (sll, srl)     | عمليات الإزاحة. |
| **Sign Extension**  | Memory, Branch               | تحويل immediate من 16 إلى 32 بت. |
| **MUX**             | كل الأنواع                  | اختيار البيانات اللي تدخل للـ ALU أو تروح لـ Register/Memory. |

---

![image](https://github.com/user-attachments/assets/4c12c5fe-cf1a-484f-b716-c1194071f160)

**ALU Instruction (R-Type)**  
→ ده نوع من التعليمات في MIPS اسمه **R-Type**، وده معناه إنه بيعتمد على 3 سجلات (registers).

---

### 📌 Format التعليمة:

```
Inst_name   rd, rs, rt
```

- `Inst_name` = اسم العملية (زي `add`, `sub`, `and`, `or`)
- `rd` = السجل اللي هيتخزن فيه الناتج (**destination register**)
- `rs` = أول مدخل (input 1)
- `rt` = تاني مدخل (input 2)

يعني مثلًا لو قلنا:
```
add $t0, $t1, $t2
```
ده معناه:
```
$t0 = $t1 + $t2
```

- القيمة اللي في `$t1` (rs) + القيمة اللي في `$t2` (rt) → تتخزن في `$t0` (rd)

---

### 🧠 إشارة OP:
الصورة موضحة إن **rs** و **rt** رايحين لـ **دائرة ALU** (الدائرة الدائرية دي) عشان تعمل العملية اللي تم تحديدها بواسطة **OP code** أو **ALU control**.

---

### ✅ مثال بسيط على كود VHDL لـ `add`, `sub`, `and`, `or`:

هفترض إن ALU بيشتغل على 32-bit أرقام:

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Simple_ALU is
    Port (
        rs     : in  std_logic_vector(31 downto 0);
        rt     : in  std_logic_vector(31 downto 0);
        ALUOp  : in  std_logic_vector(1 downto 0);  -- نحدد نوع العملية
        result : out std_logic_vector(31 downto 0)
    );
end Simple_ALU;

architecture Behavioral of Simple_ALU is
begin
    process(rs, rt, ALUOp)
    begin
        case ALUOp is
            when "00" =>  -- ADD
                result <= std_logic_vector(signed(rs) + signed(rt));
            when "01" =>  -- SUB
                result <= std_logic_vector(signed(rs) - signed(rt));
            when "10" =>  -- AND
                result <= rs and rt;
            when "11" =>  -- OR
                result <= rs or rt;
            when others =>
                result <= (others => '0');
        end case;
    end process;
end Behavioral;
```

---

لو عايزة أشرح الكود ده خطوة بخطوة أو نعمل كود يشمل حاجات أكتر زي Zero flag أو وحدة التحكم، قوليلي.

تحبي ننتقل دلوقتي للـ Sign Extension أو تكملي في ALU؟
