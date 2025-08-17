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
  signal mem: mem_type :=(	 
  
  	-- sub $R4, $R1, $R2     ; opcode = 000000, funct = 100010
    0 => "00000000",
    1 => "01000011",
    2 => "00001000",
    3 => "00100010",  -- funct=100010	

    4  => x"AA",
    5  => x"44",
    6  => x"00",
    7  => x"11",
	
    8  => x"A0",
    9  => x"A0",
    10  => x"A0",
    11  => x"A0",  	   
	
	-- sw $R1, 4($R2)        ; opcode = 101011
    12  => "10101100",
    13  => "01000001",
    14  => "00000000",
    15  => "00000100",  
	
	    -- add $R3, $R1, $R2     ; opcode = 000000, funct = 100000
    16 => "00000000",
    17 => "00100010",  -- rs=R1, rt=R2
    18 => "00011000",  -- rd=R3, shamt=00000
    19 => "00100000",  -- funct=100000	  
	
	--     -- lw $R1, 0($R2)        ; opcode = 100011
    20 => "10001100",
    21 => "01000001",
    22 => "00000000",
    23 => "00000000",  -- funct=100010	

    -- and $R5, $R1, $R2     ; opcode = 000000, funct = 100100
    32 => "00000000",
    33 => "00100010",
    34 => "00101000",
    35 => "00100100",  -- funct=100100	   
 

    -- or $R6, $R1, $R2      ; opcode = 000000, funct = 100101
    36 => "00000000",
    37 => "00100010",
    38 => "00110000",
    39 => "00100101",  -- funct=100101	   
	

    -- sle $R7, $R1, $R2     ; custom opcode = 111000 (example)
    40 => "11100000",  -- opcode = 111000
    41 => "00100010",  -- rs=R1, rt=R2
    42 => "00111000",  -- rd=R7
    43 => "00101010",  -- custom behavior

    -- beq $R1, $R2, 1       ; opcode = 000100
    44 => "00010000",
    45 => "00100010",
    46 => "00000000",
    47 => "00000001",

    -- jump 8                ; opcode = 000010
48 => "00001000",
49 => "00000000",
50 => "00000000",
51 => "00001000",

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
