library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all;

entity B_Register is
    Port (
        clk   : in  std_logic;
        B_in  : in  std_logic_vector(31 downto 0);
        B_out : out std_logic_vector(31 downto 0)
    );
end B_Register;

architecture Behavioral of B_Register is
    signal temp : std_logic_vector(31 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            temp <= B_in;
        end if;
    end process;

    B_out <= temp;
end Behavioral;
