
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  --to integer ,unsigned

entity registerfile is
  port (
    clk        : in std_logic;
    regWrite   : in std_logic;
    readReg1   : in std_logic_vector(4 downto 0);
    readReg2   : in std_logic_vector(4 downto 0);
    writeReg   : in std_logic_vector(4 downto 0);
    writeData  : in std_logic_vector(31 downto 0);
    readData1  : out std_logic_vector(31 downto 0);
    readData2  : out std_logic_vector(31 downto 0)
);

end registerfile;

architecture Behavioral of registerfile is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);  --32*32
    signal registers : reg_array := (others => (others => '0'));
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
