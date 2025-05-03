library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left2 is 
    port (
        shift_in  : in  unsigned(31 downto 0);
        shift_out : out unsigned(31 downto 0)
    );		
end entity;

architecture sims of shift_left2 is
begin
    shift_out <= shift_in SLL 2;
end architecture;
