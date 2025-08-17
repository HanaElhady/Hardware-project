library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  --to integer ,unsigned

entity registerfile is
    Port (				 
	    
        clk         : in  std_logic;
        regWrite    : in  std_logic;	 
														
        readReg1    : in  std_logic_vector(4 downto 0); -- 2^5=32 
        readReg2    : in  std_logic_vector(4 downto 0);
        writeReg    : in  std_logic_vector(4 downto 0);
		
        writeData   : in  std_logic_vector(31 downto 0);
		
        readData1   : out std_logic_vector(31 downto 0);
        readData2   : out std_logic_vector(31 downto 0)
    );
end registerfile;

architecture Behavioral of registerfile is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);  --32*32
    signal registers : reg_array := (
    0 => x"00000000",  -- Register 0
    1 => x"00000000",  -- Register 1
    2 => x"00000004",  -- Register 2
    3 => x"00000013",  -- Register 3
    4 => x"00000002",  -- Register 4
    5 => x"00000005",  -- Register 5
    6 => x"00000006",  -- Register 6
    7 => x"00000007",  -- Register 7
    8 => x"00000008",  -- Register 8
    9 => x"00000009",  -- Register 9
    10 => x"0000000A", -- Register 10
    11 => x"0000000B", -- Register 11
    12 => x"0000000C", -- Register 12
    13 => x"0000000D", -- Register 13
    14 => x"0000000E", -- Register 14
    15 => x"0000000F", -- Register 15
    others => (others => '0')  -- Initialize remaining registers to 0
    );
begin
    process(clk,regWrite)	--syncronas
    begin
        if rising_edge(clk) then
            if regWrite = '1' then
                registers(to_integer(unsigned(writeReg))) <= writeData; -- to convert ex: 00101 to groub of bits then covert it to 5 so we mean R5
			end if;														    
        end if;
    end process;				 
	
    readData1 <= registers(to_integer(unsigned(readReg1)));
    readData2 <= registers(to_integer(unsigned(readReg2)));
end Behavioral;
