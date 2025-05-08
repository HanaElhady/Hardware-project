
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
    x"00000000",  -- Register 0 ($zero)
    x"11111111",  -- Register 1 ($at)
    x"10010000",  -- Register 2 ($v0)
    x"10020000",  -- Register 3 ($v1)
    x"20030000",  -- Register 4 ($a0)
    x"20040000",  -- Register 5 ($a1)
    x"20050000",  -- Register 6 ($a2)
    x"20060000",  -- Register 7 ($a3)
    x"30070000",  -- Register 8 ($t0)
    x"30080000",  -- Register 9 ($t1)
    x"30090000",  -- Register 10 ($t2)
    x"300A0000",  -- Register 11 ($t3)
    x"300B0000",  -- Register 12 ($t4)
    x"300C0000",  -- Register 13 ($t5)
    x"300D0000",  -- Register 14 ($t6)
    x"300E0000",  -- Register 15 ($t7)
    x"400F0000",  -- Register 16 ($s0)
    x"40100000",  -- Register 17 ($s1)
    x"40110000",  -- Register 18 ($s2)
    x"40120000",  -- Register 19 ($s3)
    x"40130000",  -- Register 20 ($s4)
    x"40140000",  -- Register 21 ($s5)
    x"40150000",  -- Register 22 ($s6)
    x"40160000",  -- Register 23 ($s7)
    x"50170000",  -- Register 24 ($t8)
    x"50180000",  -- Register 25 ($t9)
    x"60000000",  -- Register 26 ($k0)
    x"60000000",  -- Register 27 ($k1)
    x"70000000",  -- Register 28 ($gp)
    x"80000000",  -- Register 29 ($sp)
    x"90000000",  -- Register 30 ($fp)
    x"A0000000"   -- Register 31 ($ra)
);
begin
    process(clk)	--syncronas
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
