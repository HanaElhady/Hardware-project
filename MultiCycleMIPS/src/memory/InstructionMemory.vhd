library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory is
    port(
        ReadAddress : in std_logic_vector(31 downto 0);
        Instruction : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavior of InstructionMemory is
    type RAM32 is array (0 to 15) of std_logic_vector(31 downto 0);
    signal IM : RAM32 := (
        x"012A4020",  -- add  $t0 = $t1 + $t2     (add $t0, $t1, $t2)
        x"014B4822",  -- sub  $t1 = $t2 - $t3     (sub $t1, $t2, $t3)
        x"8D0C0004",  -- lw   $t4, 4($t0)         (load from memory)
        x"AD0D0008",  -- sw   $t5, 8($t0)         (store to memory)
        x"014B682A",  -- slt  $t5, $t2, $t3       (slt for sle)
        x"11A00002",  -- beq  $t5, $zero, skip    (if not less)
        x"200E0001",  -- addi $t6, $zero, 1       (set sle = 1)
        x"08000009",  -- j    end                 (jump to end)
        x"200E0000",  -- addi $t6, $zero, 0       (set sle = 0)
        x"00000000",  -- nop                      (end)
        x"00000000",  -- nop
        x"00000000",  -- nop
        x"00000000",  -- nop
        x"00000000",  -- nop
        x"00000000",  -- nop
        x"00000000"   -- nop
    );
begin 
    Instruction <= x"00000000" when ReadAddress = x"003FFFFC" else 
        IM((to_integer(unsigned(ReadAddress)) - 4194304)/4);  
end architecture;
