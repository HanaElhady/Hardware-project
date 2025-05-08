library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory is
    port(
        Address   : in  std_logic_vector(31 downto 0);
        WriteData : in  std_logic_vector(31 downto 0);
		MemRead   : in  std_logic;
		MemWrite  : in  std_logic;
		ReadData  : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavior of DataMemory is
type RAM32 is array (0 to 15) of std_logic_vector(31 downto 0);
    signal DM : RAM32 := (
        x"00000000",  
        x"00000000",  
        x"00000000",  
        x"00000000",  
        x"00000000",  
        x"00000000", 
        x"00000000",  
        x"00000000",  
        x"00000000",  
        x"00000000",  
        x"00000000",  
        x"00000000",  
        x"00000000", 
        x"00000000",  
        x"00000000",  
        x"00000000"  
    );
begin  
	process (MemWrite,MemRead)
	begin
		if MemWrite ='1' then
		 DM((to_integer(unsigned(Address)) - 268500992) / 4) <= WriteData;
		end if;
		if MemRead ='1' then
	 ReadData<= DM((to_integer(unsigned(Address)) - 268500992) / 4);
	 else
            ReadData <= (others => '0');
		end if;
		end process;
					
end architecture;		
