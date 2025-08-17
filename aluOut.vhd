library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUout is
    Port (
        clk      : in  std_logic;
        reset    : in  std_logic;	
        alu_in   : in  std_logic_vector(31 downto 0); 
		
        alu_out  : out std_logic_vector(31 downto 0)
    );
end ALUout;

architecture Behavioral of ALUout is
    signal temp : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            temp <= (others => '0');
        elsif rising_edge(clk) then
                temp <= alu_in;
        end if;
    end process;

    alu_out <= temp;

end architecture;

