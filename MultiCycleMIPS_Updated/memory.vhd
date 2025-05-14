library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
  port(
    -- Inputs
    CLK       : in std_logic;
    reset     : in std_logic;
    address   : in std_logic_vector(31 downto 0);
    MemWrite  : in std_logic;
    MemRead   : in std_logic;
    WriteData : in std_logic_vector(31 downto 0);

    -- Output
    MemData   : out std_logic_vector(31 downto 0)
  );
end Memory;

architecture Behavioral of Memory is
  type mem_type is array (0 to 63) of std_logic_vector(7 downto 0);
  signal mem: mem_type := (
    -- lw $R1, 0($R2)        ; opcode = 100011
    0  => "10001100",  -- opcode(6) & rs=R2
    1  => "01000001",  -- rt=R1
    2  => "00000000",  -- offset[15:8]
    3  => "00000000",  -- offset[7:0]

    -- sw $R1, 4($R2)        ; opcode = 101011
    4  => "10101100",
    5  => "01000001",
    6  => "00000000",
    7  => "00000100",

    -- add $R3, $R1, $R2     ; opcode = 000000, funct = 100000
    8  => "00000000",
    9  => "00100010",  -- rs=R1, rt=R2
    10 => "00011000",  -- rd=R3, shamt=00000
    11 => "00100000",  -- funct=100000

    -- sub $R4, $R1, $R2     ; opcode = 000000, funct = 100010
    12 => "00000000",
    13 => "00100010",
    14 => "00100000",
    15 => "00100010",  -- funct=100010

    -- and $R5, $R1, $R2     ; opcode = 000000, funct = 100100
    16 => "00000000",
    17 => "00100010",
    18 => "00101000",
    19 => "00100100",  -- funct=100100

    -- or $R6, $R1, $R2      ; opcode = 000000, funct = 100101
    20 => "00000000",
    21 => "00100010",
    22 => "00110000",
    23 => "00100101",  -- funct=100101

    -- sle $R7, $R1, $R2     ; custom opcode = 111000 (example)
    24 => "11100000",  -- opcode = 111000
    25 => "00100010",  -- rs=R1, rt=R2
    26 => "00111000",  -- rd=R7
    27 => "00000000",  -- custom behavior

    -- beq $R1, $R2, 1       ; opcode = 000100
    28 => "00010000",
    29 => "00100010",
    30 => "00000000",
    31 => "00000001",

    -- jump 8                ; opcode = 000010
    32 => "00001000",
    33 => "00000000",
    34 => "00000000",
    35 => "00001000",

    -- filler data (e.g., memory initialized at address 50)
    50 => "00000001",

    others => "00000000"
  );

begin

  process(CLK, reset)
  begin
    if rising_edge(CLK) and MemWrite = '1' then
      mem(to_integer(unsigned(address)))     <= WriteData(31 downto 24);
      mem(to_integer(unsigned(address) + 1)) <= WriteData(23 downto 16);
      mem(to_integer(unsigned(address) + 2)) <= WriteData(15 downto 8);
      mem(to_integer(unsigned(address) + 3)) <= WriteData(7 downto 0);
    end if;
  end process;

 MemData <= mem(to_integer(unsigned(address)))     &
           mem(to_integer(unsigned(address) + 1)) &
           mem(to_integer(unsigned(address) + 2)) &
           mem(to_integer(unsigned(address) + 3)) when MemRead = '1'
          else (others => '0');


end Behavioral;
