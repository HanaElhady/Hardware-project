library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender is 
    port (
        input16  : in  std_logic_vector(15 downto 0);
        output32 : out std_logic_vector(31 downto 0)
    );		
end entity;

architecture sims of sign_extender is
begin 		
    output32 <= std_logic_vector(resize(signed(input16), 32));
end architecture;