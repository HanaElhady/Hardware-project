library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender is 
    port (
        input16  : in  signed(15 downto 0);
        output32 : out signed(31 downto 0)
    );		
end entity;

architecture sims of sign_extender is
begin 		
    output32 <= resize(input16, 32);
end architecture;
