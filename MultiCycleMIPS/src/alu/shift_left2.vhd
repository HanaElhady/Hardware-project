library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left2 is 
    port (
        shift_in  : in  std_logic_vector(31 downto 0);
        shift_out : out std_logic_vector(31 downto 0)
    );		
end entity;

architecture sims of shift_left2 is
begin
    shift_out <= std_logic_vector(unsigned(shift_in) sll 2);
end architecture;
