library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory is
    port(         
        IRWrite     : in std_logic;
        ReadAddress : in std_logic_vector(31 downto 0);        
        Instruction : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavior of InstructionMemory is
    type RAM32 is array (0 to 15) of std_logic_vector(31 downto 0);
    signal IM : RAM32 := (
        x"012A4020",  -- add  $t0, $t1, $t2
        x"014B4822",  -- sub  $t1, $t2, $t3
        x"8D0C0004",  -- lw   $t4, 4($t0)
        x"AD0D0008",  -- sw   $t5, 8($t0)
        x"014B682A",  -- slt  $t5, $t2, $t3
        x"11A00002",  -- beq  $t5, $zero, skip
        x"200E0001",  -- addi $t6, $zero, 1
        x"08000009",  -- j    end
        x"200E0000",  -- addi $t6, $zero, 0
        x"018D5824",  -- and  $t3, $t4, $t5
        x"01AE7025",  -- or   $t6, $t5, $t6
        x"00000000",  -- nop
        x"00000000",  -- nop
        x"00000000",  -- nop
        x"00000000",  -- nop
        x"00000000"   -- nop
    );

    signal instruction_reg : std_logic_vector(31 downto 0) := (others => '0');
begin

    process(IRWrite, ReadAddress)
        variable addr : integer;
    begin
        if ReadAddress = x"003FFFFC" then
            addr := 0; -- dummy nop for this address
        else
            addr := (to_integer(unsigned(ReadAddress)) - 4194304) / 4;
        end if;

        if IRWrite = '1' then
            if addr >= 0 and addr < 16 then
                instruction_reg <= IM(addr);
            else
                instruction_reg <= (others => '0'); -- default to nop on out-of-range
            end if;
        end if;
    end process;

    Instruction <= instruction_reg;

end architecture;
